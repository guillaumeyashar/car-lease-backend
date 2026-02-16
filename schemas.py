from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from models import VehicleType, ApplicationStatus


# ==============================
# VEHICLE SCHEMAS
# ==============================

class VehicleBase(BaseModel):
    brand: str
    car: str
    type: VehicleType
    price: int


class VehicleCreate(VehicleBase):
    pass


class VehicleResponse(VehicleBase):
    id: int
    date: datetime

    class Config:
        from_attributes = True


# For switching vehicle type
class SwitchType(BaseModel):
    type: VehicleType


# ==============================
# APPLICATION SCHEMAS
# ==============================

class ApplicationBase(BaseModel):
    customer_name: str


class ApplicationCreate(ApplicationBase):
    vehicle_id: int


class ApplicationResponse(BaseModel):
    id: int
    customer_name: str
    vehicle_id: int
    car: str
    brand: str
    price: int
    type: str
    status: ApplicationStatus
    file_url: Optional[str]

    class Config:
        from_attributes = True


# For updating application status (ADMIN)
class StatusUpdate(BaseModel):
    status: ApplicationStatus


