select * from employee limit 10

--1.Find total employees and attrition rate by department
SELECT department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited_employees,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_percent
FROM employee
GROUP BY department
ORDER BY attrition_rate_percent DESC;


--2.How does the average monthly income vary across job roles, and which roles have the highest attrition?
SELECT jobrole,
    ROUND(AVG(monthlyincome), 2) AS avg_income,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM employee
GROUP BY jobrole
ORDER BY avg_income DESC;


--3.What is the gender-wise distribution of attrition in the organization?
SELECT gender,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited_employees,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_percent
FROM employee
GROUP BY gender;


--4.How does the distance from home affect attrition?
SELECT attrition,
    ROUND(AVG(distancefromhome), 2) AS avg_distance_from_home
FROM employee
GROUP BY attrition;


--5.What is the average total working experience for each education field?
SELECT educationfield,
    ROUND(AVG(totalworkingyears), 2) AS avg_experience
FROM employee
GROUP BY educationfield
ORDER BY avg_experience DESC;


--6.How does salary slab and overtime status impact attrition rates?
SELECT salaryslab, overtime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_percent
FROM employee
GROUP BY salaryslab, overtime
ORDER BY attrition_percent DESC;


--7.Which top 3 job roles within each department have the highest attrition rates?
SELECT department, jobrole, attrition_rate
FROM (
  SELECT department, jobrole,
      ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate,
      RANK() OVER (PARTITION BY department ORDER BY SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) DESC) AS rnk
  FROM employee
  GROUP BY department, jobrole
) ranked
WHERE rnk <= 3
ORDER BY department, attrition_rate DESC;


--8.How does total working experience (in years) correlate with attrition?
SELECT 
    CASE 
        WHEN totalworkingyears < 5 THEN '0–5 Years'
        WHEN totalworkingyears BETWEEN 5 AND 10 THEN '5–10 Years'
        WHEN totalworkingyears BETWEEN 10 AND 20 THEN '10–20 Years'
        ELSE '20+ Years'
    END AS experience_range,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_percent
FROM employee
GROUP BY experience_range
ORDER BY attrition_percent DESC;


--9.How does business travel frequency relate to attrition?
SELECT businesstravel,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrited_employees,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM employee
GROUP BY businesstravel
ORDER BY attrition_rate DESC;


--10.What combinations of department, job role, overtime, and salary slab show the highest attrition?
SELECT department, jobrole, overtime, salaryslab,
    ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_percent
FROM employee
GROUP BY department, jobrole, overtime, salaryslab
HAVING COUNT(*) > 5
ORDER BY attrition_percent DESC
LIMIT 10;
