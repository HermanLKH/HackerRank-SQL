

WITH CTE_Submission_Summary AS
(
    SELECT
        submission_date,
        hacker_id,
        COUNT(submission_id) AS submission_count
    FROM Submissions 
    GROUP BY submission_date, hacker_id
),
CTE_Ranked_Hackers AS
(
    SELECT
        submission_date,
        hacker_id,
        ROW_NUMBER() OVER(PARTITION BY submission_date
                          ORDER     BY submission_count DESC, hacker_id)
        AS rn
    FROM CTE_Submission_Summary
),
CTE_Daily_Submissions AS
(
    SELECT 
        submission_date,
        COUNT(hacker_id) AS hacker_count
    FROM CTE_Submission_Summary css
    WHERE hacker_id IN (
        SELECT hacker_id
        FROM CTE_Submission_Summary cs2
        WHERE cs2.submission_date <= css.submission_date
        GROUP BY hacker_id
        HAVING COUNT(submission_date) = DATEDIFF(DAY, '2016-03-01', css.submission_date) + 1
    )
    GROUP BY submission_date
)
SELECT
    cds.submission_date,
    cds.hacker_count,
    crh.hacker_id AS top_hacker_id,
    h.name AS top_hacker_name
FROM CTE_Daily_Submissions cds
INNER JOIN CTE_Ranked_Hackers crh
    ON  crh.submission_date = cds.submission_date
    AND crh.rn = 1
INNER JOIN Hackers h
    ON h.hacker_id = crh.hacker_id
ORDER BY cds.submission_date;

