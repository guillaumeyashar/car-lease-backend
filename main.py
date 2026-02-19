from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from database import engine, SessionLocal, Base
import models, schemas
from fastapi.middleware.cors import CORSMiddleware
from utils.security import hash_password, verify_password

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Vehicle API with MySQL")


# CORS Configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],  # your frontend
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# ===============================
# CUSTOMER APIs
# ===============================

@app.get("/vehicles", response_model=list[schemas.VehicleResponse])
def list_vehicles(db: Session = Depends(get_db)):
    return db.query(models.Vehicle).all()


from fastapi import UploadFile, File, Form
import os
from uuid import uuid4

@app.post("/applications", response_model=schemas.ApplicationResponse)
def apply_vehicle(
    customer_id: int = Form(...),
    vehicle_id: int = Form(...),
    file: UploadFile = File(...),
    db: Session = Depends(get_db)
):
    # 1️⃣ Check if vehicle exists
    vehicle = db.query(models.Vehicle).filter(models.Vehicle.id == vehicle_id).first()
    if not vehicle:
        raise HTTPException(status_code=404, detail="Vehicle not found")

    # 2️⃣ Validate uploaded file type
    allowed_types = ["application/pdf", "image/jpeg", "image/png"]
    if file.content_type not in allowed_types:
        raise HTTPException(status_code=400, detail="Invalid file type. Only PDF, JPG, PNG allowed.")

    # 3️⃣ Save file locally
    upload_dir = "uploads"
    os.makedirs(upload_dir, exist_ok=True)
    # Mount the uploads folder at /uploads
    #app.mount("/uploads", StaticFiles(directory=UPLOAD_DIR), name="uploads")
    ext = file.filename.split(".")[-1]
    filename = f"{uuid4()}.{ext}"
    file_path = os.path.join(upload_dir, filename)

    with open(file_path, "wb") as f:
        f.write(file.file.read())

    # 4️⃣ Create application with snapshot fields and file URL
    new_app = models.Application(
        customer_name="Example Technology",
        customer_id=customer_id,
        vehicle_id=vehicle.id,
        car=vehicle.car,
        brand=vehicle.brand,
        price=vehicle.price,
        type=vehicle.type.value,  # store enum as string
        file_url=file_path
    )

    db.add(new_app)
    db.commit()
    db.refresh(new_app)

    return new_app


# ===============================
# ADMIN APIs
# ===============================

@app.post("/admin/vehicles", response_model=schemas.VehicleResponse)
def add_vehicle(data: schemas.VehicleCreate, db: Session = Depends(get_db)):
    vehicle = models.Vehicle(**data.dict())

    db.add(vehicle)
    db.commit()
    db.refresh(vehicle)

    return vehicle


@app.put("/admin/vehicles/{vehicle_id}/switch")
def switch_vehicle(vehicle_id: int, data: schemas.SwitchType, db: Session = Depends(get_db)):
    vehicle = db.query(models.Vehicle).filter(models.Vehicle.id == vehicle_id).first()

    if not vehicle:
        raise HTTPException(status_code=404, detail="Vehicle not found")

    vehicle.type = data.type
    db.commit()

    return {"message": "Vehicle type updated"}


@app.get("/admin/applications", response_model=list[schemas.ApplicationResponse])
def list_applications(db: Session = Depends(get_db)):
    return db.query(models.Application).all()


@app.put("/admin/applications/{application_id}/status")
def update_status(application_id: int, data: schemas.StatusUpdate, db: Session = Depends(get_db)):
    application = db.query(models.Application).filter(models.Application.id == application_id).first()

    if not application:
        raise HTTPException(status_code=404, detail="Application not found")

    application.status = data.status
    db.commit()

    return {"message": "Status updated"}

    
