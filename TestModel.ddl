
CREATE TABLE CUSTOMER
(
	CUSTOMER_ID          INTEGER  NOT NULL ,
	CUSTOMER_NAME        VARCHAR2(20)  NULL 
);

CREATE UNIQUE INDEX XPKCUSTOMER ON CUSTOMER
(CUSTOMER_ID   ASC);

ALTER TABLE CUSTOMER
	ADD CONSTRAINT  XPKCUSTOMER PRIMARY KEY (CUSTOMER_ID);

CREATE TABLE CUSTOMER_ORD
(
	CUSTOMER_ID          INTEGER  NOT NULL ,
	ORD_ID               INTEGER  NULL ,
	ORD_DATE             DATE  NULL 
);

CREATE UNIQUE INDEX XPKCUSTOMER_ORD ON CUSTOMER_ORD
(CUSTOMER_ID   ASC);

ALTER TABLE CUSTOMER_ORD
	ADD CONSTRAINT  XPKCUSTOMER_ORD PRIMARY KEY (CUSTOMER_ID);

ALTER TABLE CUSTOMER_ORD
	ADD (
CONSTRAINT R_1 FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID));


CREATE  TRIGGER  tD_CUSTOMER AFTER DELETE ON CUSTOMER for each row
-- erwin Builtin Trigger
-- DELETE trigger on CUSTOMER 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* CUSTOMER  CUSTOMER_ORD on parent delete restrict */
    /* ERWIN_RELATION:CHECKSUM="0000e789", PARENT_OWNER="", PARENT_TABLE="CUSTOMER"
    CHILD_OWNER="", CHILD_TABLE="CUSTOMER_ORD"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="CUSTOMER_ID" */
    SELECT count(*) INTO NUMROWS
      FROM CUSTOMER_ORD
      WHERE
        /*  %JoinFKPK(CUSTOMER_ORD,:%Old," = "," AND") */
        CUSTOMER_ORD.CUSTOMER_ID = :old.CUSTOMER_ID;
    IF (NUMROWS > 0)
    THEN
      raise_application_error(
        -20001,
        'Cannot delete CUSTOMER because CUSTOMER_ORD exists.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_CUSTOMER AFTER UPDATE ON CUSTOMER for each row
-- erwin Builtin Trigger
-- UPDATE trigger on CUSTOMER 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* CUSTOMER  CUSTOMER_ORD on parent update restrict */
  /* ERWIN_RELATION:CHECKSUM="00010e3f", PARENT_OWNER="", PARENT_TABLE="CUSTOMER"
    CHILD_OWNER="", CHILD_TABLE="CUSTOMER_ORD"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="CUSTOMER_ID" */
  IF
    /* %JoinPKPK(:%Old,:%New," <> "," OR ") */
    :old.CUSTOMER_ID <> :new.CUSTOMER_ID
  THEN
    SELECT count(*) INTO NUMROWS
      FROM CUSTOMER_ORD
      WHERE
        /*  %JoinFKPK(CUSTOMER_ORD,:%Old," = "," AND") */
        CUSTOMER_ORD.CUSTOMER_ID = :old.CUSTOMER_ID;
    IF (NUMROWS > 0)
    THEN 
      raise_application_error(
        -20005,
        'Cannot update CUSTOMER because CUSTOMER_ORD exists.'
      );
    END IF;
  END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tI_CUST_ORD BEFORE INSERT ON CUSTOMER_ORD for each row
-- erwin Builtin Trigger
-- INSERT trigger on CUSTOMER_ORD 
DECLARE NUMROWS INTEGER;
BEGIN
    /* erwin Builtin Trigger */
    /* CUSTOMER  CUSTOMER_ORD on child insert restrict */
    /* ERWIN_RELATION:CHECKSUM="0000f44d", PARENT_OWNER="", PARENT_TABLE="CUSTOMER"
    CHILD_OWNER="", CHILD_TABLE="CUSTOMER_ORD"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="CUSTOMER_ID" */
    SELECT count(*) INTO NUMROWS
      FROM CUSTOMER
      WHERE
        /* %JoinFKPK(:%New,CUSTOMER," = "," AND") */
        :new.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID;
    IF (
      /* %NotnullFK(:%New," IS NOT NULL AND") */
      
      NUMROWS = 0
    )
    THEN
      raise_application_error(
        -20002,
        'Cannot insert CUSTOMER_ORD because CUSTOMER does not exist.'
      );
    END IF;


-- erwin Builtin Trigger
END;
/




CREATE  TRIGGER tU_CUST_ORD AFTER UPDATE ON CUSTOMER_ORD for each row
-- erwin Builtin Trigger
-- UPDATE trigger on CUSTOMER_ORD 
DECLARE NUMROWS INTEGER;
BEGIN
  /* erwin Builtin Trigger */
  /* CUSTOMER  CUSTOMER_ORD on child update restrict */
  /* ERWIN_RELATION:CHECKSUM="0000f4bc", PARENT_OWNER="", PARENT_TABLE="CUSTOMER"
    CHILD_OWNER="", CHILD_TABLE="CUSTOMER_ORD"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="CUSTOMER_ID" */
  SELECT count(*) INTO NUMROWS
    FROM CUSTOMER
    WHERE
      /* %JoinFKPK(:%New,CUSTOMER," = "," AND") */
      :new.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID;
  IF (
    /* %NotnullFK(:%New," IS NOT NULL AND") */
    
    NUMROWS = 0
  )
  THEN
    raise_application_error(
      -20007,
      'Cannot update CUSTOMER_ORD because CUSTOMER does not exist.'
    );
  END IF;


-- erwin Builtin Trigger
END;
/


