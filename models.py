from sqlalchemy import Column, Integer, String, Enum, ForeignKey, DateTime
from sqlalchemy.orm import relationship
from database import Base
import enum
from datetime import datetime


class VehicleType(str, enum.Enum):
    sale = "sale"
    lease = "lease"


class ApplicationStatus(str, enum.Enum):
    pending = "pending"
    approved = "approved"
    rejected = "rejected"


# ==============================
# VEHICLE TABLE
# ==============================
class Vehicle(Base):
    __tablename__ = "vehicles"

    id = Column(Integer, primary_key=True, index=True)
    brand = Column(String(255), nullable=False)
    car = Column(String(255), nullable=False)
    type = Column(Enum(VehicleType), nullable=False)
    price = Column(Integer, nullable=False)
    date = Column(DateTime, default=datetime.utcnow)

    applications = relationship("Application", back_populates="vehicle")

class Customer(Base):
    __tablename__ = "customers"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255))
    email = Column(String(255))
    phone = Column(String(255))
    address = Column(String(255))


# ==============================
# APPLICATION TABLE
# ==============================
class Application(Base):
    __tablename__ = "applications"

    id = Column(Integer, primary_key=True, index=True)
    customer_name = Column(String(255), nullable=False)
    

    customer_id = Column(Integer, ForeignKey("customers.id"))
    vehicle_id = Column(Integer, ForeignKey("vehicles.id"))

    # Snapshot fields
    car = Column(String(255), nullable=False)
    brand = Column(String(255), nullable=False)
    price = Column(Integer, nullable=False)
    type = Column(String(255), nullable=False)

    # ✅ NEW FIELD
    file_url = Column(String(500), nullable=True)

    status = Column(Enum(ApplicationStatus), default=ApplicationStatus.pending)

    vehicle = relationship("Vehicle", back_populates="applications")

    