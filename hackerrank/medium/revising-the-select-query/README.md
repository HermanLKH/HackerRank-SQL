# Revising the Select Query I

![Difficulty](https://img.shields.io/badge/Difficulty-Medium-yellow)

## Problem

Query all columns for all American cities in the **CITY** table with populations larger than `100000`. The **CountryCode** for America is `USA`. 

The **CITY** table is described as follows:  

![CITY.jpg](https://s3.amazonaws.com/hr-challenge-images/8137/1449729804-f21d187d0f-CITY.jpg)

**Input Format**

 

**Constraints**

 

**Output Format**

## Solution

**Language:** SQL  
**Runtime:** N/A  
**Memory:** N/A  
**Submitted:** 2026-09-16T16:36:20.010Z  

```sql


SELECT *
FROM CITY
WHERE CountryCode = 'USA'
AND   Population > 100000;


```

---

[View on HackerRank](https://www.hackerrank.com/challenges/revising-the-select-query/problem)