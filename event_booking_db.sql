
DROP DATABASE IF EXISTS event_booking_db;
CREATE DATABASE event_booking_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE event_booking_db;

CREATE TABLE `user` (
    userID         INT           NOT NULL AUTO_INCREMENT,
    fullName       VARCHAR(100)  NOT NULL,
    userName       VARCHAR(50)   NOT NULL UNIQUE,
    contactNumber  VARCHAR(20)   NOT NULL,
    dateOfBirth    DATE          DEFAULT NULL,
    email          VARCHAR(100)  NOT NULL UNIQUE,
    userStatus     VARCHAR(20)   NOT NULL DEFAULT 'PENDING',
    userRole       VARCHAR(20)   NOT NULL DEFAULT 'USER',
    password       VARCHAR(255)  NOT NULL,
    profilePicture VARCHAR(255)           DEFAULT NULL,
    isDeleted      TINYINT(1)    NOT NULL DEFAULT 0,
    PRIMARY KEY (userID)
) ENGINE=InnoDB;


CREATE TABLE venue (
    venueID       INT          NOT NULL AUTO_INCREMENT,
    venueName     VARCHAR(100) NOT NULL,
    venueCapacity INT          NOT NULL,
    venueContact  VARCHAR(50)  NOT NULL,
    venueAddress  VARCHAR(255) NOT NULL,
    isDeleted     TINYINT(1)   NOT NULL DEFAULT 0,
    PRIMARY KEY (venueID)
) ENGINE=InnoDB;


CREATE TABLE event (
    eventID    INT            NOT NULL AUTO_INCREMENT,
    venueID    INT            NOT NULL,
    eventType  VARCHAR(50)    NOT NULL,
    eventPrice DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    eventDate  DATE           NOT NULL,
    eventTime  VARCHAR(10)    NOT NULL,
    isDeleted  TINYINT(1)     NOT NULL DEFAULT 0,
    PRIMARY KEY (eventID),
    CONSTRAINT fk_event_venue FOREIGN KEY (venueID)
        REFERENCES venue (venueID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;


CREATE TABLE booking (
    bookingID     INT            NOT NULL AUTO_INCREMENT,
    userID        INT            NOT NULL,
    eventID       INT            NOT NULL,
    bookingStatus VARCHAR(30)    NOT NULL DEFAULT 'PENDING',
    bookingDate   DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    totalAmount   DECIMAL(10, 2) NOT NULL,
    paymentStatus VARCHAR(30)    NOT NULL DEFAULT 'UNPAID',
    isDeleted     TINYINT(1)     NOT NULL DEFAULT 0,
    PRIMARY KEY (bookingID),
    CONSTRAINT fk_booking_user  FOREIGN KEY (userID)
        REFERENCES `user` (userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_booking_event FOREIGN KEY (eventID)
        REFERENCES event (eventID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE INDEX idx_event_date    ON event(eventDate);
CREATE INDEX idx_event_venue   ON event(venueID);
CREATE INDEX idx_booking_user  ON booking(userID);
CREATE INDEX idx_booking_event ON booking(eventID);
CREATE INDEX idx_booking_date  ON booking(bookingDate);
CREATE INDEX idx_user_status   ON `user`(userStatus);


CREATE TABLE contact_message (
    messageID   INT          NOT NULL AUTO_INCREMENT,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL,
    message     TEXT         NOT NULL,
    status      VARCHAR(20)  NOT NULL DEFAULT 'OPEN',
    createdAt   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (messageID)
) ENGINE=InnoDB;
CREATE INDEX idx_msg_status ON contact_message(status);


INSERT INTO `user` (fullName, userName, contactNumber, dateOfBirth, email, userStatus, userRole, password, isDeleted)
VALUES
    ('Pralon Basnet',
     'Pralon',
     '9800000001',
     NULL,
     'pralon@bookyourevents.com',
     'ACTIVE',
     'ADMIN',
     '123456',
     0),

    ('Miraj Pandey',
     'Miraj',
     '9800000002',
     '1998-04-12',
     'mira@example.com',
     'PENDING',
     'USER',
     '123456',
     0),

    ('Anubhav Pradhan',
     'Anu',
     '9800000003',
     '2000-09-23',
     'anubhav@example.com',
     'PENDING',
     'USER',
     '123456',
     0);

INSERT INTO venue (venueName, venueCapacity, venueContact, venueAddress, isDeleted)
VALUES
    ('Grand Ballroom',              500, '01-4441001', 'Heritage Road, Thamel, Kathmandu',        0),
    ('The Garden Hall',             200, '01-4441002', 'Sanepa Chowk, Lalitpur',                  0),
    ('Himalayan Conference Centre', 300, '01-4441003', 'Naxal, Kathmandu',                        0),
    ('Riverside Pavilion',          150, '01-4441004', 'Patan Dhoka, Lalitpur',                   0),
    ('Everest Rooftop Lounge',       80, '01-4441005', 'Jhamsikhel, Lalitpur',                    0),
    ('Valley View Amphitheatre',    600, '01-4441006', 'Bhaktapur Ring Road, Bhaktapur',          0);


INSERT INTO event (venueID, eventType, eventPrice, eventDate, eventTime, isDeleted)
VALUES
    (1, 'Gala',        15000.00, '2026-07-15', '18:00', 0),
    (2, 'Conference',   4500.00, '2026-08-10', '09:00', 0),
    (1, 'Wedding',     25000.00, '2026-09-20', '16:00', 0),
    (3, 'Corporate',    8000.00, '2026-07-28', '10:00', 0),
    (4, 'Workshop',     2500.00, '2026-08-05', '14:00', 0),
    (5, 'Fundraiser',   3500.00, '2026-08-22', '17:00', 0),
    (6, 'Concert',      5000.00, '2026-09-05', '19:00', 0),
    (3, 'Conference',   6000.00, '2026-09-15', '09:30', 0),
    (2, 'Wedding',     18000.00, '2026-10-10', '15:00', 0),
    (6, 'Gala',        12000.00, '2026-10-25', '18:30', 0);


INSERT INTO booking (userID, eventID, bookingStatus, bookingDate, totalAmount, paymentStatus, isDeleted)
VALUES
    (2, 1, 'PENDING',   NOW(), 15000.00, 'UNPAID', 0),
    (3, 2, 'CONFIRMED', NOW(),  4500.00, 'PAID',   0),
    (2, 5, 'PENDING',   NOW(),  2500.00, 'UNPAID', 0);


