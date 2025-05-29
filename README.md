# Ola Cab Booking Analysis

![image](https://github.com/user-attachments/assets/7bd32366-5039-476c-b243-60b92f487872)


## Project Overview
This project is a comprehensive SQL-based analysis of Ola cab booking data. It focuses on key metrics such as booking trends, ride cancellations, vehicle performance, customer and driver ratings, and revenue generation. Insights are derived by querying a normalized cab ride table using advanced SQL logic.

# Project Objectives
Analyze booking success rate and revenue

Identify reasons for cancellations and incomplete rides

Evaluate vehicle type performance

Study booking patterns by location, time, and day

Analyze customer and driver behavior

Evaluate payment preferences and average booking values

# Tools Used
PostgreSQL (for querying)

pgAdmin or DBeaver (for DB management)

SQL Views, CASE, CTEs, Aggregations, and Date Functions.
 
# Key Insights Summary
## 1. Booking Overview
Successful Bookings: Majority of the rides have a booking status of "Success".

Top Customers: The top 5 customers have booked the most rides.

Most Active Date: A specific date had the highest number of successful bookings.

Average Rides per Day: Daily ride distribution shows varied activity across weekdays.

## 2. Ride Distance & Ratings
Avg Ride Distance by Vehicle Type: Varies significantly by vehicle; Prime Sedan and SUV have higher average distances.

Driver Ratings: Range from low to high across vehicle types; Prime Sedan had the highest max rating.

Customer Ratings: Average ratings per vehicle type are also captured and compared.

## 3. Cancellations & Incomplete Rides
Cancellations by Customer and Driver: Clear split with drivers and customers both contributing.

Most Common Reasons:

Customer: Last-minute plan changes.

Driver: Personal or vehicle-related issues.

Incomplete Rides: Common reasons include technical issues and emergency drop-offs.

Cancellation Rate by Vehicle Type: Certain vehicle types show higher cancellation rates.

## 4. Time-Based Trends
Peak Booking Hours: Specific hours of the day show more bookings.

Weekends vs Weekdays: Weekend bookings are slightly higher or comparable depending on the day.

Match Day Impact: Bookings on match days showed higher activity compared to regular days.

## 5. Location Insights
Top Pickup Areas: A few areas dominate the pickup volume.

Frequent Pickup-Drop Pair: One route is more common than others.

Top Drop Locations: Certain locations are preferred drop-off points.

## 6. Revenue & Payments
Revenue from Success Rides: Total booking value from successful rides is significant.

Avg Booking Value by Vehicle Type: Premium vehicles tend to have higher average booking value.

Payment Modes: UPI is the most common method, followed by cash and card.

Booking Value Distribution:

Many bookings fall in the ₹500–₹1000 range.

Very few are above ₹1000.

# Data Source
The dataset used in this project was synthetically generated using an AI language model for educational and demonstration purposes. The data simulates realistic scenarios to support learning and analysis.


