# Sleep Good Night Application

## Overview
The Good Night Application allows users to track their sleep patterns and interact socially by following other users and viewing their sleep records. This project is implemented as a Rails API-only application, ensuring scalability and maintainability while adhering to RESTful design principles.

## Features

1. **Clock In**
   - Users can clock in when they go to bed.
   - Automatically assigns the current timestamp for `clock_in`.
   - Returns all clocked-in times, ordered by creation time.

2. **Clock Out**
   - Users can clock out when they wake up.
   - Automatically assigns the current timestamp for `clock_out` via a callback.

3. **Follow/Unfollow Users**
   - Users can follow or unfollow other users.

4. **View Following Users' Sleep Records**
   - Displays all sleep records of a user’s following list.
   - Filters sleep records from the past week.
   - Sorts records by sleep duration in descending order.

## Technologies Used

- **Ruby on Rails** (API-only)
- **SQLite3** (Database)
- **User authentication**
- **Jbuilder** (JSON rendering)

## API Endpoints

### User Authentication

- **Login**
  - This is just simple authentication. Need modify in the future like using Devise, use email and password in User.
  - `POST /api/v1/login`
  - Request:
    ```json
    {
      "name": "Andy"
    }
    ```
  - Response:
    ```json
    {
        "auth_token": "xxx"
    }
    ```
  - This auth_token for headers Authorization for request after login.

### Sleep Records

- **Clock In**
  - `POST /api/v1/sleep_records`
  - Response:
    ```json
    {
        "message": "Clocked in successfully",
        "sleep_record": {
            "id": 1,
            "user_id": 2,
            "clock_in": "2024-11-24T03:11:48.123Z",
            "clock_out": null,
            "created_at": "2024-11-24T03:11:48.125Z",
            "updated_at": "2024-11-24T03:11:48.125Z",
            "duration": 0
        }
    }
    ```

- **Clock Out**
  - `PATCH /api/v1/sleep_records/:id`
  - Response:
    ```json
    {
        "message": "Clocked out successfully",
        "sleep_record": {
            "user_id": 2,
            "clock_out": "2024-11-24T04:09:48.278Z",
            "duration": 0,
            "id": 1,
            "clock_in": "2024-11-24T03:11:48.123Z",
            "created_at": "2024-11-24T03:11:48.125Z",
            "updated_at": "2024-11-24T04:09:48.282Z"
        }
    }
    ```

- **Get Sleep Records of Following Users**
  - `GET /api/v1/sleep_records/:id/following_sleep_records`
  - Response:
    ```json
    {
        "friends_sleep_records": [
            {
                "id": 1,
                "user_id": 2,
                "user_name": "Roger",
                "clock_in": "2024-11-24 03:11:48.123658",
                "clock_out": "2024-11-24 03:15:30.963216",
                "duration": 0
            }
        ]
    }
    ```

### Follow/Unfollow

- **Follow User**
  - `POST /api/v1/users/:id/follow`
  - Response:
    ```json
    {
        "message": "Now following Angela"
    }
    ```

- **Unfollow User**
  - `DELETE /api/v1/users/:id/unfollow`
  - Response:
    ```json
    {
        "message": "Unfollowed Angela"
    }
    ```

## Database Schema

### Users Table
| Column      | Type    | Details               |
|-------------|---------|-----------------------|
| id          | integer | Primary key           |
| name        | string  |                       |
| auth_token  | string  | Unique authentication token |

### Sleep Records Table
| Column      | Type      | Details                          |
|-------------|-----------|----------------------------------|
| id          | integer   | Primary key                      |
| user_id     | integer   | Foreign key (references users)   |
| clock_in    | datetime  | Required                         |
| clock_out   | datetime  |                                  |
| duration    | integer   | Calculated in hours              |

### Follows Table
| Column      | Type      | Details                          |
|-------------|-----------|----------------------------------|
| id          | integer   | Primary key                      |
| follower_id | integer   | Foreign key (references users)   |
| followed_id | integer   | Foreign key (references users)   |

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd sleep_good_night
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Setup the database:
   ```bash
   rails db:create db:migrate db:seed
   ```

4. Run the server:
   ```bash
   rails server
   ```

5. Test the APIs using tools like Postman or cURL.

## Best Practices
- **Fat Model, Slim Controller:** Business logic resides in the models.
- **Callbacks:** Automatically assign `clock_in` and `clock_out` values.
- **Eager Loading:** Optimize database queries to handle large volumes of data efficiently.

## Future Improvements
- Improving authentication use Devise, etc.
- Add user registration and authentication flows.
- Implement rate limiting to handle high concurrency.
- Add more detailed analytics for user sleep patterns.

---

If you have any questions or need further clarifications, please don't hesitate to ask.