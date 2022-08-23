select * from stk..data

-- total episodes telecasted into SharkTankIndia

select max(EpNo) from stk..data
select count(distinct EpNo) from stk..data

-- pitches that had pitched onto the SharkTankIndia

select count(distinct brand) from stk..data

-- Pitches Converted(gets funding from SharkTankIndia) in Percentage


select cast(sum(a.converted_not_converted) as float)/cast(count(*) as float) total_pitches from(
select amount_invested_lakhs, case when amount_invested_lakhs>0 then 1 else 0 end as converted_not_converted from stk..data) a


-- total males participated in SharkTankIndia


select sum(male) from stk..data


-- total female partcipated into SharkTankIndia

select sum(female) from stk..data

-- Gender ratio

select sum(female)/sum(male) from stk..data


-- Total Invested Amount into the Show

select sum(amount_invested_lakhs) from stk..data


-- AVG Equity Taken by the Sharks

select avg(a.equit_taken_p) from
(select * from stk..data where equit_taken_P>0) a


-- highest deal done into SharkTankIndia

select max(amount_invested_lakhs) from stk..data


-- highest equity taken by the sharks


select max(equit_taken_p) from stk..data


-- startups having at least women

select sum(female_count) from
(select female, case when female>0 then 1 else 0 end as female_count from stk..data) a


-- pitches converted having atleast one women

select sum(b.female_count) from (
select case when a.female>0 then 1 else 0 end as female_count, a.* from
(select * from stk..data where deal !='No Deal') a)b


-- AVG team Members


select avg(team_members) from stk..data


-- amount invested per deal by SharkTankIndia


select avg(a.[Amount_Invested_lakhs]) from(
select * from stk..data where deal !='No Deal') a


-- AVG age group of contestants


select avg_age ,count(avg_age) cnt from stk..data group by  avg_age order by cnt desc


-- location group of contestent


select location ,count(location) cnt from stk..data group by location order by cnt desc


-- sector group of contestent


select sector ,count(sector) cnt from stk..data group by sector order by cnt desc


-- partner Deals


select F32 as partners ,count(F32) cnt from stk..data where F32 !='-' group by F32 order by cnt desc 


--making the matrix


select 'ashnner' as keyy,count(ashneer_amount_invested) from stk..data where ashneer_amount_invested is not null

select 'ashnner' as keyy,count(ashneer_amount_invested) from stk..data where ashneer_amount_invested is not null and  ashneer_amount_invested <>0

select 'ashnner' as keyy,sum(c.ashneer_amount_invested), avg(c.ashneer_equity_taken_P)
from (select * from stk..data where ashneer_equity_taken_P <>0 and ashneer_equity_taken_P  is not null) c


select m.keyy,m.total_deals_present, n.total_amount_invested, n.avg_equity_taken from
(select a.keyy, a.total_deals_present, b.total_deals from (

select 'Ashnner' as keyy,count(ashneer_amount_invested) total_deals_present from stk..data where ashneer_amount_invested is not null) a
inner join(
select 'Ashnner' as keyy,count(ashneer_amount_invested) total_deals from stk..data 
where ashneer_amount_invested is not null and  ashneer_amount_invested <>0) b

on a.keyy=b.keyy) m

inner join

(select 'ashnner' as keyy,sum(c.ashneer_amount_invested) total_amount_invested, avg(c.ashneer_equity_taken_P) avg_equity_taken
from (select * from stk..data where ashneer_equity_taken_P <>0 and ashneer_equity_taken_P  is not null) c) n

on m.keyy = n.keyy;



-- which is the startup in which the highest amount has been invested in each domain/sector


select c.* from
(select brand,sector,amount_invested_lakhs, rank() over(partition by sector order by amount_invested_lakhs desc) rnk
from stk..data) c

where c.rnk=1