create table ola(Date date,	Time time,	BookingID varchar(30),	BookingStatus varchar(40),	CustomerID varchar(30),VehicleType varchar(30),
PickupLocation varchar(40), DropLocation varchar(40),	
AvgVTAT decimal,AvgCTAT	 decimal,CancelledRidesbyCustomer varchar(20),	ReasonforCancellingbyCustomer varchar(50),
CancelledRidesbyDriver varchar(20),ReasonforCancellingbyDriver varchar(50),
IncompleteRides varchar(10),IncompleteRidesReason varchar(50),	BookingValue decimal,	
RideDistance decimal,DriverRatings decimal,CustomerRating decimal,payment varchar(50));
select*from ola;
--reterview succsefull bookings
create view successfulbooking as  
select bookingstatus,count(*) as bookingcount
from ola
where bookingstatus='Success'
group by 1;


select*from ola
where bookingstatus='Success';

select*from successfulbooking;

--find the avg ride   distance for each vechile type;

create view avgrideforeachvehicle as 
select vehicletype,round(avg(coalesce(ridedistance,0)),2)as avg from ola
group by 1
order by 1;
select*from avgrideforeachvehicle;

select coalesce(ridedistance,0) from ola;

--total ride cancelled by customers
select*from ola;
select  COUNT(*) AS RIDECANCELLEDBYCUSTOMER FROM OLA
WHERE bookingSTATUS='Cancelled by Customer';

--top5 customer booked most rides
select*from ola;
select customerid,count(bookingid) as booked from ola
group by 1
order by 2 desc
limit 5;


---
select*from ola;
select bookingstatus,reasonforcancellingbydriver,count(*) cancelledrides
from ola
where reasonforcancellingbydriver='Personal & Car related issues'
group by 1,2;


select count(*) as ridescancelled
from ola
where reasonforcancellingbydriver='Personal & Car related issues';

---
select*from ola;
select vehicletype ,min(driverratings) as minrating,max(driverratings) as maxrating from ola
where vehicletype='Prime Sedan'
group by 1



--
select*from ola;





SELECT COUNT(*) 
FROM information_schema.columns 
WHERE table_name = 'ola';
SELECT column_name FROM information_schema.columns WHERE table_name='ola' ORDER BY ordinal_position;



--
select payment ,count(*) as rides from ola
where payment='UPI'
group by 1



---
SELECT*FROM OLA;
SELECT VEHICLETYPE,round(COALESCE(AVG(CUSTOMERRATING),0),2) AS avgcustomerRATING
FROM OLA
GROUP BY 1;



---
select bookingstatus,sum(bookingvalue) as total
from ola
where bookingstatus='Success'
group by 1


--list incomplete rides and resons
select*from ola;
select bookingid,incompleteridesreason from ola
where incompleterides='Yes'
group by 1,2;


select incompleteridesreason ,count(*) as canceleldrides from ola
where incompleterides='Yes'
group by 1;




---ridevolume and date
select count(*) totalbooking from ola
where bookingstatus='Success';






--📊 Booking Volume & Trends
--How many total bookings were made during the month?

select*from ola;
select  bookingstatus,to_char(date,'month')as month,count(*) as booking
from ola
where bookingstatus='Success'
group by 1,2;


--What is the average number of rides per day?
select*from ola;

select to_char(date,'day') as day ,count(bookingid) as rides
from ola
group by 1;

--Compare the number of rides on weekends vs weekdays

select flag,sum(ridings) from(
SELECT 
  date,
  CASE 
    WHEN TO_CHAR(date, 'FMDay') IN ('Saturday', 'Sunday') THEN 'Weekend'
    ELSE 'Weekday'
  END AS flag,
  COUNT(BookingID) AS ridings
FROM ola
GROUP BY 1, 2
ORDER BY date)
group by 1;



--Which date had the highest number of bookings?
select date,count(*) as booking from ola
group by 1
order by 2 desc
limit 1;

--What percentage of total bookings were successful?
select bookingstatus,round(count(bookingid)*100.0/(select count(bookingid) from ola),2)  as pct from ola
where bookingstatus='Success'
group by 1;

--🚫 Cancellations & Incomplete Rides
--How many rides were cancelled by customers and drivers respectively?
select bookingstatus,count(bookingid)  as rides from ola
where bookingstatus in ('Cancelled by Customer','Cancelled by Driver')
group by 1;


--What is the most common reason for customer cancellations?
select*from ola;
select reasonforcancellingbycustomer ,count(*) as reasonscount from ola
where cancelledridesbycustomer='Yes'
group by 1
order by 2 desc
limit 1;



--What is the most common reason for driver cancellations?
select reasonforcancellingbydriver ,count(*) as reasonscount from ola
where cancelledridesbydriver='Yes'
group by 1
order by 2 desc
limit 1;

--What percentage of bookings were incomplete?
select bookingstatus ,round(count(*)*100.0/(select count(incompleterides) from ola ) ,2)as rides from ola
where incompleterides='Yes'
group by 1;


--What are the top reasons for incomplete rides?
select incompleteridesreason,count(*) as reasons
from ola 
where incompleterides='Yes'
group by 1
order by 2 desc
limit 1;

--🚖 Vehicle Performance
--Which vehicle type has the highest number of bookings?
select vehicletype,count(*) as bookings
from ola
group by 1
order by 2 desc
limit 2;

--Which vehicle type has the highest average booking value?
select vehicletype,round(avg(bookingvalue),2) avgvalue from ola
group by 1
order by 2 desc
limit 2;

select avg(bookingvalue) as avgvalue from ola;
--Compare driver ratings across different vehicle types.
select vehicletype,count(driverratings ) as driverrating from ola
group by 1;

--Which vehicle type has the highest cancellation rate?
SELECT 
  VehicleType,
  COUNT(*) AS total_bookings,
  SUM(CASE WHEN CancelledRidesbyCustomer = 'Yes' THEN 1 ELSE 0 END) AS customer_cancellations,
  SUM(CASE WHEN CancelledRidesbyDriver = 'Yes' THEN 1 ELSE 0 END) AS driver_cancellations,
  ROUND(
    (SUM(CASE WHEN CancelledRidesbyCustomer = 'Yes' THEN 1 ELSE 0 END) +
     SUM(CASE WHEN CancelledRidesbyDriver = 'Yes' THEN 1 ELSE 0 END)) * 100.0
    / COUNT(*), 2) AS total_cancellation_rate_percent
FROM ola
GROUP BY VehicleType
ORDER BY total_cancellation_rate_percent DESC;


select vehicletype,count(*) totalbooking ,
sum(case when CancelledRidesbyCustomer='Yes' then 1 else 0 end) customercancel, sum(case when CancelledRidesbyDriver='Yes' then 1 else 0 end) drivercancel, 
round((sum(case when CancelledRidesbyCustomer='Yes' then 1 else 0 end)  + 
sum(case when CancelledRidesbyDriver='Yes' then 1 else 0 end)) *100.0/count(*),2) as cancelrating 
from ola
group by 1

--📍 Location-Base
--Which area has the highest number of pickups?
select*from ola;
select pickuplocation,count(*) as pickups
from ola
group by 1
order by 2 desc
limit 3;

--Which pickup-drop pair is the most frequent?
select pickuplocation,droplocation,count(*) pickupdrop from ola
group by 1,2
order by 3 desc
limit 1;

--List the top 5 drop locations with most rides.
select droplocation ,count(bookingid) as rides
from ola
group by 1
order by 2 desc
limit 5 ;


--🕒 Time & Performance
--What is the average VTAT and CTAT for successful rides?
select bookingstatus, round(avg(coalesce(avgvtat,0) ),2)as avgvtat,round(avg(coalesce(avgctat,0)),2) as avgctat from ola
where bookingstatus='Success'
group by 1;


--Which time of day (hour) sees the most bookings?
select extract(hour from time) as hour,count(*) as booking from ola
group by 1
order by 2 desc
limit ;


---Compare booking trends during match days vs non-match days.
select bookingstatus,to_char(date,'day') as day ,COUNT(*) AS BOOKING from ola
group by 1,2
ORDER BY 2 


SELECT 
  CASE 
    WHEN date IN ('2025-04-07', '2025-04-14', '2025-04-21') THEN 'Match Day'
    ELSE 'Non-Match Day'
  END AS match_day_flag,
  COUNT(*) AS total_bookings
FROM ola
GROUP BY 1;


--💸 Revenue & Payments
--What is the total revenue generated from successful bookings?
SELECT BOOKINGSTATUS,SUM(bookingvalue) as revenue from ola
where bookingstatus='Success'
group by 1;


--What is the average booking value per vehicle type?
select vehicletype,round(avg(bookingvalue),2) as avgvalue from ola
group by 1


--How many rides were paid via UPI, Cash, and Card?
select bookingstatus,payment,count(*) as rides from ola
where bookingstatus='Success'
group by 1,2;


--What is the distribution of booking values: < ₹500, ₹500–1000, > ₹1000?
select*from ola;
select bookingvalue,(case when bookingvalue<500 then 'Below 500'
                                   when bookingvalue>=500 then '500-1000' 
								   when bookingvalue>1000 then 'above 1000' end) as distribution from ola
where bookingstatus='Success';












---Which payment method is most common among customers?
select payment,count(*) as rides from ola
where bookingstatus='Success'
group by 1
order by 2 desc
limit 1;
order by 2 desc;



select count(*) as totalbooking from ola
where bookingstatus='Success';

