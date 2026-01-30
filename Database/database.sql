-- ================================
-- DATABASE
-- ================================
CREATE DATABASE IF NOT EXISTS rental_monitoring_system;
USE rental_monitoring_system;

-- ================================
-- ROLE TABLE
-- ================================
CREATE TABLE role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- ================================
-- USER TABLE
-- ================================
CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE',

    FOREIGN KEY (role_id) REFERENCES role(role_id)
);

-- ================================
-- PROPERTY TABLE
-- ================================
CREATE TABLE property (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    property_name VARCHAR(100) NOT NULL,
    location VARCHAR(150) NOT NULL,
    property_type VARCHAR(50),
    status VARCHAR(20) DEFAULT 'ACTIVE',

    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- ================================
-- UNIT TABLE
-- ================================
CREATE TABLE unit (
    unit_id INT AUTO_INCREMENT PRIMARY KEY,
    property_id INT NOT NULL,
    unit_number VARCHAR(50) NOT NULL,
    rent_amount DECIMAL(10,2) NOT NULL,
    occupancy_status VARCHAR(20) DEFAULT 'VACANT',

    FOREIGN KEY (property_id) REFERENCES property(property_id)
);

-- ================================
-- TENANT TABLE
-- ================================
CREATE TABLE tenant (
    tenant_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    national_id VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    status VARCHAR(20) DEFAULT 'ACTIVE'
);

-- ================================
-- LEASE TABLE
-- ================================
CREATE TABLE lease (
    lease_id INT AUTO_INCREMENT PRIMARY KEY,
    tenant_id INT NOT NULL,
    unit_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    lease_status VARCHAR(20) DEFAULT 'ACTIVE',

    FOREIGN KEY (tenant_id) REFERENCES tenant(tenant_id),
    FOREIGN KEY (unit_id) REFERENCES unit(unit_id)
);

-- ================================
-- INVOICE TABLE
-- ================================
CREATE TABLE invoice (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    lease_id INT NOT NULL,
    billing_month VARCHAR(20) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    due_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',

    FOREIGN KEY (lease_id) REFERENCES lease(lease_id)
);

-- ================================
-- PAYMENT TABLE
-- ================================
CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50),
    reference_code VARCHAR(100),

    FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id)
);

-- ================================
-- MAINTENANCE TABLE
-- ================================
CREATE TABLE maintenance (
    maintenance_id INT AUTO_INCREMENT PRIMARY KEY,
    unit_id INT NOT NULL,
    reported_by VARCHAR(50),
    issue_description TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'OPEN',
    cost DECIMAL(10,2),
    reported_date DATE NOT NULL,
    resolved_date DATE,

    FOREIGN KEY (unit_id) REFERENCES unit(unit_id)
);

-- ================================
-- NOTIFICATION TABLE
-- ================================
CREATE TABLE notification (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    notification_type VARCHAR(50),
    sent_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- ================================
-- BACKUP LOG TABLE
-- ================================
CREATE TABLE backup_log (
    backup_id INT AUTO_INCREMENT PRIMARY KEY,
    backup_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    backup_type VARCHAR(50),
    status VARCHAR(20)
);
