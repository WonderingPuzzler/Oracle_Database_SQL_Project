-- Matthew Perez
-- 5/10/24



DROP TABLE complaint CASCADE CONSTRAINTS;

DROP TABLE customer CASCADE CONSTRAINTS;

DROP TABLE facility CASCADE CONSTRAINTS;

DROP TABLE fee CASCADE CONSTRAINTS;

DROP TABLE fee_inspection CASCADE CONSTRAINTS;

DROP TABLE illness_complaint CASCADE CONSTRAINTS;

DROP TABLE illness_information CASCADE CONSTRAINTS;

DROP TABLE inspect_off CASCADE CONSTRAINTS;

DROP TABLE inspection CASCADE CONSTRAINTS;

DROP TABLE inspector CASCADE CONSTRAINTS;

DROP TABLE point_of_contact CASCADE CONSTRAINTS;



CREATE TABLE complaint (
    comp_date     DATE NOT NULL,
    comp_facility VARCHAR2(255),
    comp_text     VARCHAR2(510),
    comp_type     CHAR(35) CHECK ( comp_type IN ( 'Employee Conduct', 'Illness', 'Other', 'Sanitary Conditions' ) ),
    fac_id        INTEGER NOT NULL,
    cust_id       INTEGER NOT NULL
);

ALTER TABLE complaint ADD CONSTRAINT complaint_pk PRIMARY KEY ( fac_id,
                                                                cust_id,
                                                                comp_date);

CREATE TABLE customer (
    cust_first_name VARCHAR2(50),
    cust_last_name  VARCHAR2(50),
    cust_street     VARCHAR2(125),
    cust_street_2   VARCHAR2(125),
    cust_city       VARCHAR2(50),
    cust_state      CHAR(10) CHECK ( cust_state IN ( 'IA', 'NE' ) ),
    cust_zip_code   CHAR(5),
    cust_phone      CHAR(12),
    cust_email      VARCHAR2(310),
    cust_age        INTEGER,
    cust_gender     VARCHAR2(50),
    cust_id         INTEGER NOT NULL
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( cust_id );

CREATE TABLE facility (
    fac_name         VARCHAR2(255),
    fac_general_type CHAR(35) CHECK ( fac_general_type IN ( 'Bar', 'Caterer', 'Limited Food', 'Mobile', 'Restaurant',
                                                            'Retail', 'School', 'Stand Alone Bakery' ) ),
    fac_id           INTEGER NOT NULL,
    fac_risk_level   CHAR(10) CHECK ( fac_risk_level = 'High'
                                    OR fac_risk_level = 'Low'
                                    OR fac_risk_level = 'Medium'
                                    OR fac_risk_level IN ( 'High', 'Low', 'Medium' ) ),
    fac_overall_sanitation_rating CHAR(10) CHECK ( fac_overall_sanitation_rating IN ( 'BMS', 'Excellent', 'Fair', 'Standard', 'Superior') ),
    fac_street   VARCHAR2(125),
    fac_street_2 VARCHAR2(125),
    fac_city     VARCHAR2(50),
    fac_state    CHAR(10) CHECK ( fac_state IN ( 'IA', 'NE' ) ),
    fac_zip_code CHAR(5)
    
);

ALTER TABLE facility ADD CONSTRAINT facility_id PRIMARY KEY ( fac_id );

ALTER TABLE facility
    ADD CONSTRAINT street3 UNIQUE (fac_street);




CREATE TABLE fee (
    fee_activity_type     VARCHAR2(70) NOT NULL,
    fee_initial_permit    FLOAT,
    fee_first_prep_area   FLOAT,
    fee_no_food_prep_area FLOAT,
    fee_add_food_prep     FLOAT
);

ALTER TABLE fee ADD CONSTRAINT fee_pk PRIMARY KEY ( fee_activity_type );

CREATE TABLE fee_inspection (
    fee_activity_type       VARCHAR2(70) NOT NULL,
    insp_date_of_inspection DATE NOT NULL,
    fac_id                  INTEGER NOT NULL
);

ALTER TABLE fee_inspection
    ADD CONSTRAINT fee_inspection_pk PRIMARY KEY ( fee_activity_type,
                                                   insp_date_of_inspection,
                                                   fac_id );

CREATE TABLE illness_complaint (
    comp_date               DATE NOT NULL,
    illness_number_ill      INTEGER,
    illness_still_ill       VARCHAR2(3) CHECK ( illness_still_ill IN ( 'No', 'Yes' ) ),
    illness_date_symp       DATE,
    info_causative_pathogen VARCHAR2(150) NOT NULL,
    fac_id                  INTEGER NOT NULL,
    cust_id                 INTEGER NOT NULL
);

ALTER TABLE illness_complaint ADD CONSTRAINT illness_complaint_pk PRIMARY KEY ( fac_id,
                                                                                cust_id);

ALTER TABLE illness_complaint ADD CONSTRAINT illness_complaint_pkv1 UNIQUE ( info_causative_pathogen );

CREATE TABLE illness_information (
    info_causative_pathogen VARCHAR2(150) NOT NULL,
    info_incubation_time    VARCHAR2(150),
    info_length_of_illness  VARCHAR2(150)
);

ALTER TABLE illness_information ADD CONSTRAINT illness_information_pk PRIMARY KEY ( info_causative_pathogen );

CREATE TABLE inspect_off (
    off_num                       INTEGER NOT NULL,
    off_name                      VARCHAR2(255),
    off_street                    VARCHAR2(125),
    off_street_2                  VARCHAR2(125),
    off_city                      VARCHAR2(50),
    off_state                     CHAR(10) CHECK ( off_state IN ( 'IA', 'NE' ) ),
    off_zip_code                  CHAR(5),
    off_main_contact_person_fname VARCHAR2(50),
    off_phone_number              CHAR(12),
    off_email_address             VARCHAR2(310),
    off_main_contact_person_lname VARCHAR2(50)
);


ALTER TABLE inspect_off ADD CONSTRAINT inspection_office_pk PRIMARY KEY ( off_num );

ALTER TABLE inspect_off
    ADD CONSTRAINT street2 UNIQUE ( off_street);

CREATE TABLE inspection (
    insp_food_source               CHAR(10) CHECK ( insp_food_source IN ( 'BMS', 'Excellent', 'Fair', 'Standard', 'Superior' ) ),
    insp_proper_food_temp_control  CHAR(10) CHECK ( insp_proper_food_temp_control IN ( 'BMS', 'Excellent', 'Fair', 'Standard', 'Superior'
    ) ),
    insp_personal_hygiene          CHAR(10) CHECK ( insp_personal_hygiene IN ( 'BMS', 'Excellent', 'Fair', 'Standard', 'Superior' ) )
    ,
    insp_cleaning   CHAR(10) CHECK ( insp_cleaning IN ( 'BMS', 'Excellent', 'Fair', 'Standard', 'Superior'
    ) ),
    insp_insect   CHAR(10) CHECK ( insp_insect IN ( 'BMS', 'Excellent', 'Fair', 'Standard', 'Superior'
    ) ),
    insp_waste_disposal            CHAR(10) CHECK ( insp_waste_disposal IN ( 'BMS', 'Excellent', 'Fair', 'Standard', 'Superior' ) ),
    insp_final_rating              CHAR(10) CHECK ( insp_final_rating IN ( 'BMS', 'Excellent', 'Fair', 'Standard', 'Superior' ) ),
    insp_date_of_inspection        DATE NOT NULL,
    insp_risk_description          VARCHAR2(255),
    inspect_id                     INTEGER NOT NULL,
    fac_id                         INTEGER NOT NULL,
    off_num                        INTEGER NOT NULL
);

ALTER TABLE inspection ADD CONSTRAINT inspection_pk PRIMARY KEY ( insp_date_of_inspection,
                                                                  fac_id);

CREATE TABLE inspector (
    inspect_first_name           VARCHAR2(125),
    inspect_last_name            VARCHAR2(125),
    inspect_hire_date            DATE,
    inspect_certification_date   DATE,
    inspect_contact_phone_number CHAR(12),
    inspect_email_address        VARCHAR2(310),
    inspect_id                   INTEGER NOT NULL,
    off_num                      INTEGER NOT NULL
);

ALTER TABLE inspector ADD CONSTRAINT inspector_pk PRIMARY KEY ( inspect_id,
                                                                off_num );

CREATE TABLE point_of_contact (
    poc_fname        VARCHAR2(50),
    poc_lname        VARCHAR2(50),
    poc_phone_number CHAR(12),
    poc_email        VARCHAR2(310),
    poc_id           INTEGER NOT NULL,
    fac_id           INTEGER NOT NULL
);

CREATE UNIQUE INDEX point_of_contact__idx ON
    point_of_contact (
        fac_id
    ASC );

ALTER TABLE point_of_contact ADD CONSTRAINT point_of_contact_pk PRIMARY KEY ( poc_id,
                                                                              fac_id,
                                                                              poc_email);

ALTER TABLE illness_complaint
    ADD CONSTRAINT hierarchy_1 FOREIGN KEY ( fac_id,
                                             cust_id, comp_date)
        REFERENCES complaint ( fac_id,
                               cust_id,
                               comp_date)
            ON DELETE CASCADE;

ALTER TABLE illness_complaint
    ADD CONSTRAINT relation_13 FOREIGN KEY ( info_causative_pathogen )
        REFERENCES illness_information ( info_causative_pathogen )
            ON DELETE CASCADE;

ALTER TABLE complaint
    ADD CONSTRAINT relation_14 FOREIGN KEY ( cust_id )
        REFERENCES customer ( cust_id )
            ON DELETE CASCADE;

ALTER TABLE complaint
    ADD CONSTRAINT relation_16 FOREIGN KEY ( fac_id )
        REFERENCES facility ( fac_id )
            ON DELETE CASCADE;

ALTER TABLE fee_inspection
    ADD CONSTRAINT relation_18 FOREIGN KEY ( fee_activity_type )
        REFERENCES fee ( fee_activity_type )
            ON DELETE CASCADE;

ALTER TABLE inspection
    ADD CONSTRAINT relation_19 FOREIGN KEY ( inspect_id,
                                             off_num )
        REFERENCES inspector ( inspect_id,
                               off_num )
            ON DELETE CASCADE;

ALTER TABLE point_of_contact
    ADD CONSTRAINT relation_2 FOREIGN KEY ( fac_id )
        REFERENCES facility ( fac_id )
            ON DELETE CASCADE;

ALTER TABLE fee_inspection
    ADD CONSTRAINT relation_20 FOREIGN KEY ( insp_date_of_inspection,
                                             fac_id )
        REFERENCES inspection ( insp_date_of_inspection,
                                fac_id )
            ON DELETE CASCADE;

ALTER TABLE inspector
    ADD CONSTRAINT relation_22 FOREIGN KEY ( off_num )
        REFERENCES inspect_off ( off_num )
            ON DELETE CASCADE;

ALTER TABLE inspection
    ADD CONSTRAINT relation_29 FOREIGN KEY ( fac_id )
        REFERENCES facility ( fac_id )
            ON DELETE CASCADE;
