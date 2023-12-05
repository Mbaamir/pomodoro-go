-- name: CreateTask :one
INSERT INTO
    task (name, description, pomo_user_id)
VALUES
    ($1, $2, $3) RETURNING *;

-- name: CompleteTask :one
UPDATE task
SET
    completed_at = NOW ()
WHERE
    id = $1 RETURNING *;

-- name: DeleteTask :exec
DELETE FROM task
WHERE
    id = $1;

-- name: GetTasksOfUser :many
SELECT
    *
FROM
    task
WHERE
    pomo_user_id = $1;