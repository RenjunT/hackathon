--create a table for refugees
CREATE TABLE Refugees (
    refugee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    registration_date DATE NOT NULL,
    registered_by_actor_id INT NOT NULL,
    FOREIGN KEY (registered_by_actor_id) REFERENCES Actors(actor_id),
    notes TEXT
);

--medical data for health-care records
CREATE TABLE MedicalRecords (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    refugee_id INT NOT NULL,
    healthcare_actor_id INT NOT NULL,
    diagnosis TEXT,
    prescribed_treatment TEXT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (refugee_id) REFERENCES Refugees(refugee_id),
    FOREIGN KEY (healthcare_actor_id) REFERENCES Actors(actor_id)
);

--tracks accomodation availibility for municipalities
CREATE TABLE Accommodation (
    accommodation_id INT AUTO_INCREMENT PRIMARY KEY,
    location_name VARCHAR(255) NOT NULL,
    max_capacity INT NOT NULL,
    current_occupancy INT NOT NULL,
    status ENUM('Available', 'Full', 'Under Maintenance') NOT NULL,
    updated_by_actor_id INT NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (updated_by_actor_id) REFERENCES Actors(actor_id)
);

--monitor servies provided by NGOs
CREATE TABLE Services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    refugee_id INT NOT NULL,
    ngo_actor_id INT NOT NULL,
    service_type ENUM('Food', 'Job Assistance', 'Legal Aid', 'Other') NOT NULL,
    service_date DATE NOT NULL,
    notes TEXT,
    FOREIGN KEY (refugee_id) REFERENCES Refugees(refugee_id),
    FOREIGN KEY (ngo_actor_id) REFERENCES Actors(actor_id)
);

--facilitates real-time updates and alerts between actors
CREATE TABLE Notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_actor_id INT NOT NULL,
    receiver_actor_id INT NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Unread', 'Read') DEFAULT 'Unread',
    FOREIGN KEY (sender_actor_id) REFERENCES Actors(actor_id),
    FOREIGN KEY (receiver_actor_id) REFERENCES Actors(actor_id)
);

--audit logs: tracks changes and access for accountability
CREATE TABLE AuditLogs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    actor_id INT NOT NULL,
    action VARCHAR(255) NOT NULL,
    description TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (actor_id) REFERENCES Actors(actor_id)
);
