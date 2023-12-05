-- name: CreateUser :one
INSERT INTO
    pomo_user (username, pin)
VALUES
    ($1, $2) RETURNING id,username;

-- name: ChangePin :exec
UPDATE pomo_user
SET
    pin = $1
WHERE
    id = $2;