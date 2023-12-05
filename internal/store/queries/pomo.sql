-- name: CreatePomo :one
INSERT INTO
    pomo (subtask_id)
VALUES
    ($1) RETURNING *;

-- name: CompletePomo :one
UPDATE pomo
SET
    is_completed = TRUE,
    is_running = FALSE,
    completed_at = NOW ()
WHERE
    id = $1 RETURNING *;

-- name: CancelPomo :one
UPDATE pomo
SET
    is_completed = FALSE,
    is_running = FALSE
WHERE
    id = $1 RETURNING *;

-- name: GetRunningPomoOfSubTask :one
SELECT
    *
FROM
    pomo
WHERE
    subtask_id = $1
    AND is_running = TRUE
LIMIT
    1;

-- name: GetCompletedPomosOfSubTask :many
SELECT
    *
FROM
    pomo
WHERE
    subtask_id = $1
    AND is_completed = TRUE;

-- name: GetAllPomosOfSubTask :many
SELECT
    *
FROM
    pomo
WHERE
    subtask_id = $1;