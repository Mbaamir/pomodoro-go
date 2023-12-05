CREATE TABLE "pomo" (
  "id" SERIAL PRIMARY KEY,
  "started_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "completed_at" TIMESTAMPTZ,
  "is_completed" BOOLEAN NOT NULL DEFAULT FALSE,
  "is_running" BOOLEAN NOT NULL DEFAULT TRUE,
  "subtask_id" INT NOT NULL
);

CREATE TABLE "subtask" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "description" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "completed_at" TIMESTAMPTZ,
  "pomos_required" INT NOT NULL,
  "task_id" INT NOT NULL
);

CREATE TABLE "task" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "description" TEXT,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "completed_at" TIMESTAMPTZ,
  "pomo_user_id" INT NOT NULL
);

CREATE TABLE "pomo_user" (
  "id" SERIAL PRIMARY KEY,
  "username" VARCHAR(255) NOT NULL,
  "pin" CHAR(4) NOT NULL
);

ALTER TABLE "pomo_user"
ADD CONSTRAINT "chk_users_pin_format"
CHECK (pin ~ '^\d{4}$'); --means a 4 digit number

ALTER TABLE "pomo" ADD FOREIGN KEY ("subtask_id") REFERENCES "subtask" ("id");

ALTER TABLE "subtask" ADD FOREIGN KEY ("task_id") REFERENCES "task" ("id");

ALTER TABLE "task" ADD FOREIGN KEY ("pomo_user_id") REFERENCES "pomo_user" ("id");