# 15 Days of Learning SQL

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

Julia conducted a $15$ days of learning SQL contest. The start date of the contest was _March 01, 2016_ and the end date was _March 15, 2016_. 

Write a query to print total number of unique hackers who made at least $1$ submission each day (starting on the first day of the contest), and find the _hacker\_id_ and _name_ of the hacker who made maximum number of submissions each day. If more than one such hacker has a maximum number of submissions, print the lowest *hacker\_id*. The query should print this information for each day of the contest, sorted by the date.

----

**Input Format**

The following tables hold contest data:

- _Hackers:_ The _hacker\_id_ is the id of the hacker, and _name_ is the name of the hacker.<img src="https://s3.amazonaws.com/hr-challenge-images/19597/1458511164-12adec3b8b-ScreenShot2016-03-21at3.26.47AM.png"/>

- _Submissions:_ The _submission\_date_ is the date of the submission, _submission\_id_ is the id of the submission, _hacker\_id_ is the id of the hacker who made the submission, and _score_ is the score of the submission. <img src="https://s3.amazonaws.com/hr-challenge-images/19597/1458511251-0b534030b9-ScreenShot2016-03-21at3.26.56AM.png"/>

**Constraints**

 

**Output Format**

## Solution

**Language:** SQL  
**Runtime:** N/A  
**Memory:** N/A  
**Submitted:** 2026-09-17T04:00:45.550Z  

```sql


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


```

---

[View on HackerRank](https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem)