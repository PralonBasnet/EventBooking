<img width="2558" height="1381" alt="Screenshot 2026-05-21 131419" src="https://github.com/user-attachments/assets/2abb26e8-f654-456e-8e29-4181da86485a" /># EventBooking

A Jakarta EE web application for booking events at venues, with a full admin approval workflow.

Built from scratch with servlets, JSP, and plain JDBC — no Spring, no Hibernate — to deeply understand the request lifecycle, MVC, and the DAO pattern.

![EventBooking screenshot](docs/screenshot.png)

## What it does

- Users can browse venues and book events
- Admin reviews bookings through a PENDING → APPROVED/REJECTED workflow
- Authentication with bcrypt password hashing (jBCrypt)
- Soft delete for venues and events — no data is permanently lost
- Role-based access via an authentication filter
- Dark-themed responsive UI written in plain CSS

## Tech stack

| Layer | Tech |
|-------|------|
| Language | Java 21 |
| Web | Jakarta EE, Servlets, JSP, JSTL |
| Data access | Plain JDBC |
| Database | MySQL 8 |
| Auth | jBCrypt for password hashing |
| Build | Maven |
| Server | Tomcat 10.1 |

## Why we built it this way

We deliberately avoided Spring and Hibernate. They're great in production, but using them on a learning project means you never really see how a web request is handled, how sessions work, or how a DAO maps rows to objects. Building this with plain servlets and JDBC forced me to understand the moving parts that frameworks usually hide.

## Project structure
src/main/
├── java/
│   ├── servlets/          # Request handlers (booking, admin, auth)
│   ├── models/            # Event, Venue, Booking entities
│   ├── dao/               # Data access objects (JDBC layer)
│   ├── filters/           # Authentication filter
│   └── utils/             # Helpers (password hashing, etc)
└── webapp/
├── WEB-INF/
│   ├── web.xml        # Servlet configuration
│   └── jsp/           # Protected JSP pages
├── css/               # Dark theme styles
├── js/                # Client-side scripts
└── index.jsp          # Home page

## Running locally

**Prerequisites:** Java 21, Maven, MySQL 8, Tomcat 10.1

1. Clone the repo
```bash
   git clone https://github.com/PralonBasnet/EventBooking.git
   cd EventBooking
```

2. Create the database
```bash
   mysql -u root -p < event_booking_db.sql
```

3. Update database credentials in `src/main/resources/db.properties`

4. Build the WAR
```bash
   mvn clean package
```

5. Deploy `target/EventBooking.war` to Tomcat 10.1

6. Open `http://localhost:8080/EventBooking`

## What we'd do differently next time

- Add a repository layer over JDBC to make the DAOs unit-testable
- Write integration tests for the booking approval flow
- Move config out of `web.xml` toward annotations or external properties
- Consider exposing a REST API for a future mobile or React frontend

---
