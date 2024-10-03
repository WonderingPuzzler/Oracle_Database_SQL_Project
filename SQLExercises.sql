-- Matthew Perez
-- 5/10/24

--Query 1 - Writes a single SQL SELECT statement to select the address, the risk rating, the overall sanitation rating, the name and phone number of the point-of-contact person for the 'Marvel Diner' facility/facility


select FACILITY.FAC_STREET, FACILITY.FAC_STREET_2, FACILITY.FAC_CITY, FACILITY.FAC_STATE, FACILITY.FAC_ZIP_CODE, FACILITY.FAC_RISK_LEVEL, FACILITY.FAC_OVERALL_SANITATION_RATING, POINT_OF_CONTACT.POC_FNAME, POINT_OF_CONTACT.POC_LNAME, POINT_OF_CONTACT.POC_PHONE_NUMBER 
from FACILITY 
join POINT_OF_CONTACT 
on FACILITY.FAC_ID = POINT_OF_CONTACT.FAC_ID 
where FACILITY.FAC_ID = 1;



--Query 2 - Writes a single SQL SELECT statement to select the first and last names of each inspector in your database working for ‘Wandavision Inspections’. Include the hire date, certification date, and e-mail address of each inspector. Order the records by the certification date, with the most recent certification date first. 


select INSPECT_FIRST_NAME, INSPECT_LAST_NAME, INSPECT_HIRE_DATE, INSPECT_CERTIFICATION_DATE, INSPECT_EMAIL_ADDRESS
from INSPECTOR
where OFF_NUM = 1
order by INSPECT_CERTIFICATION_DATE;



--Query 3 - Writes a single SQL SELECT statement to select all complaints filed against 'Marvel Diner' facility. Selects the name, address, and phone number of the customer filing the complaint, the date of the complaint, the type of complaint, and the comments left by the complainant. Order the results by date with the newest complaint listed last and the oldest listed first.


select CUSTOMER.CUST_FIRST_NAME, CUSTOMER.CUST_LAST_NAME, CUSTOMER.CUST_STREET, CUSTOMER.CUST_STREET_2, CUSTOMER.CUST_CITY, CUSTOMER.CUST_STATE, CUSTOMER.CUST_ZIP_CODE, CUSTOMER.CUST_PHONE, COMPLAINT.COMP_DATE, COMPLAINT.COMP_TYPE, COMPLAINT.COMP_TEXT
from CUSTOMER
join COMPLAINT 
on CUSTOMER.CUST_ID = COMPLAINT.CUST_ID
where COMPLAINT.FAC_ID = 1
order by COMPLAINT.COMP_DATE; 



--Query 4 - Writes a single SQL SELECT statement to select the names and addresses of all facilities with an inspection date of ‘15-Oct-2023’. Include the overall rating in your results. 


select FACILITY.FAC_NAME, FACILITY.FAC_STREET, FACILITY.FAC_STREET_2, FACILITY.FAC_CITY, FACILITY.FAC_STATE, FACILITY.FAC_ZIP_CODE, INSPECTION.INSP_FINAL_RATING
from FACILITY
join INSPECTION
on FACILITY.FAC_ID = INSPECTION.FAC_ID
where INSPECTION.INSP_DATE_OF_INSPECTION = '15-OCT-2023';



--Query 5 - Write a single SQL SELECT statement to select all the inspection information recorded for all inspections conducted by ‘Stephen Rogers’.

select INSPECTION.INSP_FOOD_SOURCE, INSPECTION.INSP_PROPER_FOOD_TEMP_CONTROL, INSPECTION.INSP_PERSONAL_HYGIENE, INSPECTION.INSP_CLEANING, INSPECTION.INSP_INSECT, INSPECTION.INSP_WASTE_DISPOSAL, INSPECTION.INSP_FINAL_RATING, INSPECTION.INSP_DATE_OF_INSPECTION, INSPECTION.INSP_RISK_DESCRIPTION, INSPECTION.INSPECT_ID, INSPECTION.FAC_ID, INSPECTION.OFF_NUM, FACILITY.FAC_NAME 
from INSPECTION 
join INSPECTOR 
on INSPECTION.OFF_NUM = INSPECTOR.OFF_NUM
join FACILITY
on INSPECTION.FAC_ID = FACILITY.FAC_ID 
where INSPECTOR.INSPECT_FIRST_NAME = 'Stephen'
and INSPECTOR.INSPECT_LAST_NAME = 'Rogers';



--Query 6 - Writes the name of facility, street adress of facility, facility type, overall rating, and date of most recent inspection.

select FACILITY.FAC_NAME, FACILITY.FAC_STREET, FACILITY.FAC_GENERAL_TYPE, FACILITY.FAC_OVERALL_SANITATION_RATING, INSPECTION.INSP_DATE_OF_INSPECTION 
from FACILITY
join INSPECTION
on FACILITY.FAC_ID = INSPECTION.FAC_ID
where INSPECTION.INSP_DATE_OF_INSPECTION =
      (select max(INSP_DATE_OF_INSPECTION)
       from INSPECTION
       where FAC_ID = FACILITY.FAC_ID)
order by FACILITY.FAC_NAME;



--Query 7 - The 'Marvel Diner' facility was just inspected again on ‘17-Nov-2023' and received the highest ratings in all categories with a new overall rating of 'Superior'. Writes a SQL INSERT statement and UPDATE statement to reflect this inspection in your database.

insert into INSPECTION
values ('Superior', 'Superior', 'Superior', 'Superior', 'Superior', 'Superior', 'Superior', '17-NOV-2023', 'Perfection incarnate!', 4, 1, 3);

update FACILITY
set FAC_OVERALL_SANITATION_RATING = 'Superior'
where FAC_ID = 1;



--Query 8 For the inspection at the 'Marvel Diner' conducted by 'Stephen Rogers' on ‘15-Oct-2023’, selects the facility name, inspector name, and all fees charged.

select FACILITY.FAC_NAME, INSPECTOR.INSPECT_FIRST_NAME, INSPECTOR.INSPECT_LAST_NAME, FEE.FEE_INITIAL_PERMIT, FEE.FEE_FIRST_PREP_AREA, FEE.FEE_NO_FOOD_PREP_AREA, FEE.FEE_ADD_FOOD_PREP
from INSPECTION
join FACILITY 
on INSPECTION.FAC_ID = FACILITY.FAC_ID
join FEE_INSPECTION 
on INSPECTION.FAC_ID = FEE_INSPECTION.FAC_ID
join INSPECTOR 
on INSPECTION.INSPECT_ID = INSPECTOR.INSPECT_ID
join FEE 
on FEE_INSPECTION.FEE_ACTIVITY_TYPE = FEE.FEE_ACTIVITY_TYPE
where FACILITY.FAC_NAME = 'Marvel Diner' 
and INSPECTOR.INSPECT_FIRST_NAME = 'Stephen' 
and INSPECTOR.INSPECT_LAST_NAME = 'Rogers' 
and INSPECTION.INSP_DATE_OF_INSPECTION = '15-OCT-2023';




--Query 9 - One of the  facilities is no longer in business. Writes the appropriate SQL DELETE statements to completely remove this facility from the database. 


delete from FACILITY
where FAC_ID = 4;

delete from POINT_OF_CONTACT
where FAC_ID = 4;

delete from INSPECTION 
where FAC_ID = 4;

delete from FEE_INSPECTION
where FAC_ID = 4;

delete from COMPLAINT
where FAC_ID = 4;

delete from ILLNESS_COMPLAINT
where FAC_ID = 4;

