select * 
from Donation_Data

SELECT *
FROM Donor_Data2

SELECT COUNT(*) AS total_donations
FROM Donation_Data

--Sum total donations in the dayabaseDonation_Data
SELECT SUM(donation) AS total_donation_amount
FROM Donation_Data;

--Average donation amount--
SELECT AVG(donation) AS avg_donation_amount
FROM Donation_Data;

--donation distribution amounts per state
SELECT state, donation
FROM Donation_Data
GROUP BY state
ORDER BY donation desc

--donation frequency--
SELECT donation_frequency, COUNT(*) AS num_donors
FROM Donor_Data2
GROUP BY donation_frequency
ORDER BY donation_frequency;

--donors that donated more than once--
SELECT id, donation, COUNT(*) AS num_repeat_donors
FROM (
  SELECT id, donation
  FROM Donation_Data
  GROUP BY id
  HAVING COUNT(*) > 1
) AS repeat_donors;

--donations by gender
SELECT gender, AVG(donation) AS avg_donation
FROM Donor_Data2 d
JOIN Donation_Data dn ON d.id = dn.id
GROUP BY gender;

--count num of females donating--
SELECT gender, COUNT(donation) AS Gender_count
FROM Donor_Data2 d
JOIN Donation_Data dn ON d.id = dn.id
GROUP BY gender;

--average donation by jobfield--
SELECT job_field, state, AVG(donation) AS avg_donation
FROM Donor_Data2 d
JOIN Donation_Data dn ON d.id = dn.id
GROUP BY job_field
order by avg_donation DESC


SELECT COUNT(*) AS num_donors, AVG(donation) AS avg_donation
FROM (
    SELECT id, COUNT(*) AS num_donations, SUM(donation) AS total_donation
    FROM Donation_Data
    GROUP BY id
    HAVING num_donations > 1
 )AS donor_donation_info;

--Creating temp tables so we can query this for more complex queries--
WITH donor_donation_info AS (
  SELECT donor.id AS donor_id, first_name, last_name, email, gender, job_field, state, shirt_size,
         donation, donation_channel, donation_date, donation_frequency, university, car, second_language,
         favourite_colour, favourite_movie_genre
  FROM Donor_Data2 d
  JOIN Donation_Data dd ON d.id = dd.donor_id
)
SELECT *
FROM donor_donation_info;

SELECT State, Job_Field, COUNT(*) as Donations
FROM Donation_Data
INNER JOIN Donor_Data2 ON Job_Field = Job_Field
GROUP BY State, Job_Field
ORDER BY Donations DESC;


SELECT donation_frequency, Sum(donation) AS Donation_Amount, count(donation) as Num_donors
FROM Donor_Data2 d
join Donation_Data dn on d.id = dn.id
where donation_frequency = 'Yearly'
or donation_frequency = 'Monthly'
or donation_frequency = 'Once'
or donation_frequency = 'Weekly'
GROUP BY donation_frequency
ORDER BY donation_frequency;

select job_field, avg(donation) as avg_donation 
from Donation_Data
group by job_field
order by avg_donation DESC

SELECT Donation_Data.state, count(donation) 
as Donor_count, sum(donation) as StateDonationAmount
FROM Donor_Data2
JOIN Donation_Data
ON Donor_Data2.id = Donation_Data.id
GROUP BY Donation_Data.state
order by StateDonationAmount DESC
limit 10

