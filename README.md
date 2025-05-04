# RB Notifications API 📧🚀

This is a simple Rails API to send email notifications using SendGrid and Sidekiq.

## Getting Started 🏁

First, regardless of the method you choose below, you need to set up your environment variables:

1.  **Environment Setup:**
    Rename `.env.example` to `.env` and fill in your SendGrid API key and verified sender email:
    ```plaintext
    # .env
    SENDGRID_API_KEY=YOUR_SENDGRID_API_KEY_HERE
    SENDGRID_SINGLE_SENDER_EMAIL=your_verified_sender@example.com
    ```
    *Note: `SENDGRID_SINGLE_SENDER_EMAIL` **must** be an email address you have verified with SendGrid. See [SendGrid Sender Verification](https://docs.sendgrid.com/ui/sending-email/sender-verification) for details.*

Now, choose how you want to run the application:

### Option 1: Running with Docker Compose 🐳 (Recommended)

1.  **Ensure `.env` is created** (See "Environment Setup" above).
2.  **Build and Run:**
    ```bash
    docker-compose up --build
    ```
    This command will build the images and start the `web`, `sidekiq`, and `redis` services using the variables from your `.env` file. The API will be available at `http://localhost:3000`.

### Option 2: Running Locally 💻

1.  **Ensure `.env` is created** (See "Environment Setup" above).
2.  **Install Dependencies:**
    Make sure you have Ruby and Bundler installed.
    ```bash
    bundle install
    ```

3.  **Install Redis:**
    Sidekiq requires Redis. If you don't have it installed:
    ```bash
    # Example for Ubuntu/Debian
    sudo add-apt-repository ppa:redislabs/redis
    sudo apt update
    sudo apt install redis-server
    ```
    *(Adjust commands based on your OS)*

4.  **Start Redis:**
    ```bash
    redis-server
    ```
    *(Or use `sudo systemctl start redis-server` if installed as a service)*

5.  **Start Sidekiq:**
    Open a new terminal window/tab:
    ```bash
    bundle exec sidekiq
    ```

6.  **Start the Rails Server:**
    Open another new terminal window/tab:
    ```bash
    ./bin/rails server
    ```
    The API will be available at `http://localhost:3000`.

## Testing the Endpoint 🧪

You can send emails by making a POST request to the `/send_message` endpoint.

**Example using `curl`:**

```bash
curl -X POST http://localhost:3000/send_message \
-H "Content-Type: application/json" \
-d '{
  "message": "SOS! 🌊 Found this message in a bottle. Send help... or maybe just pizza? 🍕 Stranded on a digital island! 🏝️",
  "emails": ["recipient1@example.com", "recipient2@example.com"]
}'
```

You should receive a `{"status":"Emails are being processed"}` response, and the emails will be sent in the background via Sidekiq.
Ps.: After sending e-mails for test purposes, consider checking the **SPAM** box.

## Sidekiq Web UI Monitoring ✨

You can monitor the background jobs via the Sidekiq Web UI, available at:
`http://localhost:3000/sidekiq`

## Running Tests 🧪

This project uses RSpec for testing. To run the test suite, use:

```bash
bundle exec rspec
```
