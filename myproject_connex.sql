CREATE TABLE catalogue(
codeg number(10) constraint pk_catalogue primary key,
titre varchar2(200) NOT NULL,
NomAut  varchar2(80) NOT NULL,
prenomAut  varchar2(80) NOT NULL,
anEd number (4),
editeur varchar(50) NOT NULL,
Prix Number(8,3));

create table exemplaire(
codexp VARCHAR(10),
codeg number(10) NOT NULL,
etat char(8) NOT NULL,
disp char(3) NOT NULL,
constraint pk_exemplaire primary key(codexp),
constraint fk_exemplaire_catalogue foreign key(codeg) references catalogue(codeg),
constraint ck_exemplaire_etat check (etat IN ('bon','moyen','mediocre')),
 constraint ck_exemplaire_disp check (disp IN ('oui','non')));
 
 create table Adherent(
noAdh number(6) constraint pk_membres primary key,
nom varchar2(80) NOT NULL,
prenom varchar2(80) NOT NULL,
adresse varchar2(200) NOT NULL,
ncin NUMBER (8) UNIQUE,
tel NUMBER(10),
dateAdh DATE NOT NULL,
email VARchar(80) NOT NULL);

CREATE TABLE Emprunt(
codexp varchar(10) NOT NULL,
dateEmp DATE NOT NULL,
noAdh number(6) NOT NULL,
dateRprevue DATE NOT NULL,
datereffective DATE,
constraint fk_emprunts_codexp foreign key (codexp)references exemplaire(codexp),
constraint fk_emprunts_adh foreign key (noAdh) references adherent (noadh), 
constraint pk_emprunts primary key (codexp, dateemp));

INSERT INTO Catalogue VALUES (100, 'Base de donnees','ADIBA','Michel',1995,'atlas',70);
INSERT INTO Catalogue VALUES (200, 'Base des objets','COLLAND','Rollet',1990,'atlas', 58);
INSERT INTO Catalogue VALUES (300, 'OO DMBS','ADIBA','Michel',1998,'eyrolls', 45);
INSERT INTO Catalogue VALUES (400, 'ORACLE SQL','LINDEN','Brian',2000, 'eyrolls',60);
INSERT INTO Catalogue VALUES (500, 'SQL*Plus reference','LINDEN','Brian',2001,'eyrolls', 63);
INSERT INTO Catalogue VALUES (600, 'Web Database','BUYENS','Jim',2000,'eyrolls', 73);

select * from catalogue;

INSERT INTO Exemplaire VALUES ('BDD_01', 100, 'bon', 'oui');
INSERT INTO Exemplaire VALUES ('BDD_02', 100, 'bon', 'oui');
INSERT INTO Exemplaire VALUES ('BD0_01', 200, 'bon', 'oui');
INSERT INTO Exemplaire VALUES ('OOMS_01', 300, 'mediocre', 'non');
INSERT INTO Exemplaire VALUES ('OOMS_02', 300, 'bon', 'oui');
INSERT INTO Exemplaire VALUES ('ORA.SQL_01', 400, 'bon', 'oui');
INSERT INTO Exemplaire VALUES ('SQLP_01', 500, 'bon', 'oui');
INSERT INTO Exemplaire VALUES ('WDB_00', 600, 'moyen', 'oui');

/********************Package Adherent**********************/
/**** fonction ajouter adherent : must be new****/
CREATE OR REPLACE PACKAGE Pa_Adherent AS
PROCEDURE addAdherent(noAdh1 number,nom1 varchar2,prenom1 varchar2,adresse1 varchar2
,ncin1 number,tel1 number,dateAdh1 DATE,email1 varchar);
procedure deleteAdherent(noAdh1 number);
procedure searchAdherentByCin(ncin1 in NUMBER, noadh1 out number,nom1 out varchar2 ,prenom1 out varchar2,adresse1 out varchar2,tel1 out number,dateAdh1 out date,email1 out varchar);
procedure modifyAdherent(ncin1 in NUMBER,adresse1 in varchar2,tel1 in number,email1 in varchar);
procedure getAdherents(mycursor out SYS_REFCURSOR);
END Pa_Adherent;

set serveroutput on
CREATE OR REPLACE PACKAGE BODY Pa_Adherent AS
PROCEDURE addAdherent(noAdh1 number,nom1 varchar2,prenom1 varchar2,adresse1 varchar2
,ncin1 number,tel1 number,dateAdh1 DATE,email1 varchar) is

nbAdh numeric;
ExistingUser exception;

begin
select count(noAdh) into nbAdh from Adherent where noadh=noAdh1 and ncin=ncin1;
IF nbAdh > 0 then
    /*raise ExistingUser;*/
    DBMS_OUTPUT.PUT_LINE(nbAdh);
ELSE
    insert into Adherent values(noAdh1,nom1,prenom1,adresse1,ncin1,tel1,dateAdh1,email1);
end if;

exception
when ExistingUser then
DBMS_OUTPUT.PUT_LINE('Unable to add an already existing user !!');
commit;
end addAdherent;
/*end Pa_Adherent;*/

/*Delete Adherent : must not be in Emprunt Table*/

procedure deleteAdherent(noAdh1 number) is
nbAdhInEmp number;
ExistingAdhInEmp exception;
begin
select count(noadh) into nbAdhInEmp from emprunt where noAdh=noAdh1;
if nbAdhInEmp >0 then
raise ExistingAdhInEmp;

else
delete from Adherent where noAdh=noAdh1;
end if;
Exception 
WHEN ExistingAdhInEmp then
DBMS_OUTPUT.PUT_LINE('Unable to add an already existing user in Emprunt Table !!');
commit;
end deleteAdherent;

 procedure searchAdherentByCin(ncin1 in NUMBER,noadh1 out number , nom1 out varchar2 ,prenom1 out varchar2,adresse1 out varchar2,tel1 out number,dateAdh1 out date,email1 out varchar)
is
begin
select nom,noadh,prenom,adresse,tel,dateAdh,email into 
nom1,noadh1,prenom1,adresse1,tel1,dateAdh1,email1 from Adherent where ncin=ncin1;
exception
when NO_DATA_FOUND then
dbms_output.put_line('Adherent not existing !!');
end searchAdherentByCin;

procedure modifyAdherent(ncin1 in number,adresse1 in varchar2,tel1 in number,email1 in varchar)
is
nb numeric;
noSuchAdh exception;
begin
select count(noAdh) into nb from Adherent where ncin=ncin1;
if nb>0 then
update adherent set adresse=adresse1 , tel=tel1 , email=email1 where ncin=ncin1;
dbms_output.put_line('nb is'||nb);
else 
raise noSuchAdh;
end if;
exception
when noSuchAdh then
dbms_output.put_line('Error ! cannot edit non existing adherent');
commit;
end modifyAdherent;

procedure getAdherents(mycursor out SYS_REFCURSOR)
is
begin
open mycursor for select * from Adherent ;
end getAdherents;

end Pa_Adherent;

/* End of Adherent Package*


/*Debugging START*/
insert into ADHERENT values (1,'nom1','prenom1','adr1',111111,27111111,'8/8/2001','nom1@gmail.com');

/*Pa_Adherent.addAdherent(2,'nom1','prenom1','adr1',111111,27111111,'8/8/2001','nom1@gmail.com');*/
begin
Pa_Adherent.addAdherent(12,'nom3','prenom3','adr3',22222191,2733333,'3/3/2001','nom1@gmail.com1');
commit;
end;


select * from Adherent;


begin
Pa_Adherent.deleteAdherent(9);
commit;
end;



create or replace procedure deleteproc(noAdh number) is
nbAdhInEmp number;
ExistingAdhInEmp exception;
begin
select count(noadh) into nbAdhInEmp from emprunt where emprunt.noAdh=noAdh;
if nbAdhInEmp >0 then
raise ExistingAdhInEmp;

else
delete from Adherent where Adherent.noAdh=noAdh;
end if;
Exception 
WHEN ExistingAdhInEmp then
DBMS_OUTPUT.PUT_LINE('Unable to add an already existing user in Emprunt Table !!');
end deleteproc;


/*Debugging END Here*/
set serveroutput on
create or replace procedure searchAdherentByCin(ncin1 in NUMBER, nom1 out varchar2 ,prenom1 out varchar2,adresse1 out varchar2,tel1 out number,dateAdh1 out date,email1 out varchar)
is
begin
select nom,prenom,adresse,tel,dateAdh,email into 
nom1,prenom1,adresse1,tel1,dateAdh1,email1 from Adherent where ncin=ncin1;
exception
when NO_DATA_FOUND then
dbms_output.put_line('Adherent not existing !!');
end;

set serverout on
create or replace procedure modifyAdherent(ncin1 in number,adresse1 in varchar2,tel1 in number,email1 in varchar2)
is
nb numeric;
noSuchAdh exception;
begin
select count(noAdh) into nb from Adherent where ncin=ncin1;
if nb>0 then
update adherent set adresse=adresse1 , tel=tel1 , email=email1 where ncin=ncin1;
dbms_output.put_line('nb is'||nb);
else 
raise noSuchAdh;
end if;
exception
when noSuchAdh then
dbms_output.put_line('Error ! cannot edit non existing adherent');
end;


/*modify procedure*/

begin
Pa_Adherent.modifyAdherent(333331,'newadrv',1273330,'nnewnom1@gmail.com');
end;

/*Search Adherent by cin procedure*/

declare
nom11 varchar2(80);
prenom1 varchar2(80);
adresse1 varchar2(200);
tel1 number(10);
dateAdh1 date;
email1 varchar(80);
begin
Pa_Adherent.searchAdherentByCin(2222219,nom11,prenom1,adresse1,tel1,dateAdh1,email1);
dbms_output.put_line('nom is '||nom11);
end;


/* get list of adherents*/

set serveroutput on
create or replace procedure getAdherents(mycursor out SYS_REFCURSOR)
is
begin
open mycursor for select * from Adherent ;
end getAdherents;

declare
c SYS_REFCURSOR;
vadh Adherent%ROWTYPE;
begin
getAdherents(c);
loop
fetch c into vadh;
exit when c%NOTFOUND;
dbms_output.put_line(vadh.nom);
end loop;
end;







/************************************************************************************************************************/
/************************************************************/
/************************************************************/
/************************************************************/
/************************************************************/
/************************************************************/
CREATE OR REPLACE PACKAGE Pa_Exemplaire AS
PROCEDURE addExemplaire(codexp1 varchar,codeg1 number);
procedure suppExempalaire(codexp1 varchar);
procedure modifyExemplaire(codexp1 varchar,etat1 char,disp1 char);
procedure searchExemplaireByCodeG(codeg1 number,myCursor out SYS_REFCURSOR);
procedure searchExemplaireByTitle(titre1 varchar2,myCursor out SYS_REFCURSOR);
procedure searchExemplaireByAuthorName(NomAut1  varchar2,myCursor out SYS_REFCURSOR);
procedure searchExempByTitleAndAutName(titre1 varchar2,NomAut1  varchar2,myCursor out SYS_REFCURSOR);
END Pa_Exemplaire;

set serveroutput on
CREATE OR REPLACE PACKAGE BODY Pa_Exemplaire AS
procedure addExemplaire(codexp1 varchar,codeg1 number) is
nb numeric;
exempExisting exception;
begin
select count(codexp) into nb from exemplaire where codexp=codexp1;
if nb=0 then
    insert into exemplaire values(codexp1,codeg1,'bon','oui');
else
    raise exempExisting;
end if;
exception 
when exempExisting then
    dbms_output.put_line('Error : Exemplaire already existing !!');
end addExemplaire;

procedure suppExempalaire(codexp1 varchar) is
nb numeric;
expExistingInEmprunt exception;
begin
select count(codexp) into nb from emprunt where codexp=codexp1;
if nb>0 then
    update exemplaire set disp='non' where codexp=codexp1;
    raise expExistingInEmprunt;
else
    delete from exemplaire where codexp=codexp1;
end if;
exception
when expExistingInEmprunt then
dbms_output.put_line('Error : Cannot delete an already existing <<Exemplaire>> in Emprunt , status becomes unavailable!!');
end suppExempalaire;

procedure modifyExemplaire(codexp1 varchar,etat1 char,disp1 char) is
nb numeric;
noSuchExemplaire exception;
begin
select count(codexp) into nb from exemplaire where codexp=codexp1;
if nb>0 then
    update exemplaire set etat=etat1 , disp=disp1 where codexp=codexp1;
else
    raise noSuchExemplaire;
end if;
exception 
when noSuchExemplaire then
dbms_output.put_line('Cannot modify a non existing <<Exemplaire>>');
end modifyExemplaire;

procedure searchExemplaireByCodeG(codeg1 number,myCursor out SYS_REFCURSOR) is 
begin
open myCursor for select * from exemplaire where codeg=codeg1;
end searchExemplaireByCodeG;

procedure searchExemplaireByTitle(titre1 varchar2,myCursor out SYS_REFCURSOR) is
begin
open myCursor for select codexp,e.codeg,etat,disp from exemplaire e,catalogue g where e.codeg=g.codeg and titre=titre1;
end searchExemplaireByTitle;

procedure searchExemplaireByAuthorName(NomAut1  varchar2,myCursor out SYS_REFCURSOR)is
begin
open myCursor for select codexp,e.codeg,etat,disp from exemplaire e,catalogue g where e.codeg=g.codeg and nomAut=NomAut1;
end searchExemplaireByAuthorName;

procedure searchExempByTitleAndAutName(titre1 varchar2,NomAut1  varchar2,myCursor out SYS_REFCURSOR) is
begin
open myCursor for select codexp,e.codeg,etat,disp from exemplaire e,catalogue g where e.codeg=g.codeg and nomAut=NomAut1 and titre=titre1;
end searchExempByTitleAndAutName;

end Pa_Exemplaire;



/*** DEBUG **/
select* from exemplaire;
select * from catalogue;
select * from emprunt;
select * from adherent;

delete from emprunt;

insert into emprunt values('BDD_03','10/4/2019',11,'20/4/2019',NULL);

begin
Pa_Exemplaire.addExemplaire('BDD_50',100);
end;

begin
pa_exemplaire.suppexempalaire('BDD_50');
end;

begin
pa_exemplaire.modifyexemplaire('BDD_50','mediocre','oui');
end;



declare
c SYS_REFCURSOR;
vexemp exemplaire%ROWTYPE;
begin
pa_exemplaire.searchexemplairebycodeG(100,c);
loop
fetch c into vexemp;
exit when c%NOTFOUND;
dbms_output.put_line(vexemp.codexp||' '||vexemp.codeg);
end loop;
end;


declare
c SYS_REFCURSOR;
vexemp exemplaire%ROWTYPE;
begin
pa_exemplaire.searchexemplairebytitle('OO DMBS',c);
loop
fetch c into vexemp;
exit when c%NOTFOUND;
dbms_output.put_line(vexemp.codexp||' '||vexemp.codeg);
end loop;
end;


declare
c SYS_REFCURSOR;
vexemp exemplaire%ROWTYPE;
begin
pa_exemplaire.searchexemplairebyauthorname('LINDEN',c);
loop
fetch c into vexemp;
exit when c%NOTFOUND;
dbms_output.put_line(vexemp.codexp||' '||vexemp.codeg);
end loop;
end;

declare
c SYS_REFCURSOR;
vexemp exemplaire%ROWTYPE;
begin
pa_exemplaire.searchexempbytitleandautname('OO DMBS','ADIBA',c);
loop
fetch c into vexemp;
exit when c%NOTFOUND;
dbms_output.put_line(vexemp.codexp||' '||vexemp.codeg);
end loop;
end;


/* Q 8*/

/*VEnprunt(noAdh,nom,ncin,codeg,titre,dateempr,dateRprevue,dateReffective)*/
/*create or replace view VEnprunt (noAdh,nom,ncin,codeg,titre,dateempr,dateRprevue,dateReffective) 
as select e.noadh,a.nom,a.ncin,epl.codeg,cat.titre,e.dateEmp,e.dateRprevue,e.dateReffective from Emprunt e,exemplaire epl,Adherent a ,catalogue cat
where e.noadh=a.noadh and e.codexp=epl.codexp and epl.codeg = cat.codeg;*/

create or replace view VEnprunt (noAdh,nom,ncin,codexp,titre,dateempr,dateRprevue,dateReffective) 
as select e.noadh,a.nom,a.ncin,e.codexp,cat.titre,e.dateEmp,e.dateRprevue,e.dateReffective from Emprunt e,exemplaire epl,Adherent a ,catalogue cat
where e.noadh=a.noadh and e.codexp=epl.codexp and epl.codeg = cat.codeg;


select * from Adherent;
select * from exemplaire;
select * from catalogue;
select * from emprunt;
select * from venprunt;
insert into venprunt values (11,'wass',3232,99,'new catof','19/3/2019','11/4/2019',NULL); /* Don't work ==> instead of trigger */
update venprunt set dateempr='14/3/2019' where noAdh=11; /* work like a champ*/

/*
create or replace trigger tr_VEnprunt instead of insert on venprunt for each row
declare
nbemp numeric;
nbadh numeric;
Vcodexp VARCHAR(10);
begin
select count(*) into nbemp from emprunt where emprunt.noadh=:NEW.noadh;
select count(*) into nbadh from adherent where adherent.noadh=:NEW.noadh;
if nbemp>0 and nbadh >0 then
    raise_application_error(-20101,'Emprunt and Adherent Already existing !!');
ELSE
    if nbemp=0 then 
    select codexp into Vcodexp from exemplaire epl,catalogue cat where epl.codeg=cat.codeg and epl.codeg=:NEW.codeg;
    insert into emprunt values (Vcodexp,:NEW.dateempr,:NEW.noAdh,:NEW.dateRprevue,:NEW.dateReffective);
    end if;
    if nbadh=0 then
    insert into Adherent values(:NEW.noAdh,:NEW.nom,'undefined','undefined',:NEW.ncin,11111,'1/1/1111','1/1/1111');
    end if;
end if;    
end;*/



create or replace trigger tr_VEnprunt instead of insert on venprunt for each row
declare
nbemp numeric:=0;
nbadh numeric:=0;
begin
select count(*) into nbemp from emprunt where noadh=:NEW.noadh and dateEmp=:NEW.dateempr;
select count(*) into nbadh from adherent where noadh=:NEW.noadh;
if nbemp>0 and nbadh >0 then
    raise_application_error(-20101,'Emprunt and Adherent Already existing !!');
ELSE
    if nbadh=0 then
    insert into Adherent values(:NEW.noAdh,:NEW.nom,'undefined','undefined',:NEW.ncin,11111,'1/1/1111','1/1/1111');
    end if;
    if nbemp=0 then 
    insert into emprunt values (:NEW.codexp,:NEW.dateempr,:NEW.noAdh,:NEW.dateRprevue,:NEW.dateReffective);
    end if;
end if;    
end;

insert into venprunt values (12,'wass',3232,'OOMS_01','OO DMBS','19/3/2019','11/4/2019',NULL);

/* Q 9)1*/
/*Retard */
/*drop table retard;*/
CREATE TABLE RETARD(
noAdh number(6) NOT NULL,
codeg number(10) NOT NULL,
dateEmp DATE NOT NULL,
datereffective DATE,
penalite number,
encours char(3),
constraint fk_retard_adh foreign key (noAdh) references adherent (noadh), 
constraint fk_retard_codeg foreign key (codeg)references catalogue(codeg),
constraint pk_retard primary key (noAdh,codeg),
constraint ck_retard_encours check (encours IN ('oui','non')));


create or replace trigger Tr_retard after update on emprunt for each row
declare
Vcodeg number(10);
Vprix Number(8,3);
diffDate number;
begin
    select cat.codeg,prix into Vcodeg,Vprix from catalogue cat,exemplaire epl where cat.codeg=epl.codeg and codexp=:OLD.codexp;
    diffDATE:=:NEW.dateReffective-:OLD.dateRprevue;
    IF diffDATE<=30 then
        insert into RETARD values (:OLD.noAdh,Vcodeg,:OLD.dateEmp,:NEW.dateReffective,diffDATE,'oui');
    ELSE 
        IF diffDATE >30 and diffDATE<90 then
            insert into RETARD values (:OLD.noAdh,Vcodeg,:OLD.dateEmp,:NEW.dateReffective,2*diffDATE,'oui');
        else
            insert into RETARD values (:OLD.noAdh,Vcodeg,:OLD.dateEmp,:NEW.dateReffective,Vprix,'oui');
        end if;
    END IF;
end;

select * from catalogue;
select * from exemplaire;
select * from emprunt ;
update emprunt set dateReffective='2/2/2022' where codexp='BDD_03' ;
select * from retard;
delete from retard;
/*Manipulating Dates TEST 
declare
d1 DATE;
d2 DATE;
begin
d1:='11/4/2020';
d2:='13/4/2020';
dbms_output.put_line('result is ');
dbms_output.put_line(d2-d1);
end;*/

/*select cat.codeg,count(codexp) 
    from catalogue cat,exemplaire epl where cat.codeg=epl.codeg
    group by cat.codeg;*/

/*  Q9)2 */
create or replace procedure updateReatard is
begin
    update retard set encours='non' where sysdate=datereffective+penalite and encours='oui';
    commit;
end updateReatard;

BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
       job_name             => 'update_retard_to_no_job',
       job_type             => 'PLSQL_BLOCK',
       job_action           => 'BEGIN denyAccess; END;',
       start_date           =>  sysdate,
       repeat_interval      => 'FREQ=DAILY',
       enabled              =>  TRUE,
       comments             => 'Revoke expired penalties');
END;


/*   Q 10 )   */

create or replace view VStatistiques2018 as 
select cat.codeg as ouvrage,count(codexp) as nbexp ,
    (select count(codexp) from exemplaire epl1,catalogue cat1 where epl1.codeg=cat1.codeg and cat.codeg=cat1.codeg and epl1.etat='mediocre') as nbexpnondispo,
    (select count(emp.codexp) from emprunt emp,exemplaire epl2,catalogue cat2 where emp.codexp=epl2.codexp and epl2.codeg=cat2.codeg and cat2.codeg=cat.codeg ) as nbemprunt,
    (select count(codeg) from retard where codeg=cat.codeg)
    *100/(select count(codexp) from exemplaire where codeg=cat.codeg) as pourcentageRetard
    from catalogue cat,exemplaire epl where cat.codeg=epl.codeg
    group by cat.codeg;

select * from vstatistiques2018;

/*   Q11)   */

select * from exemplaire;
select * from adherent;
select * from emprunt;
delete from adherent where noadh=21;
commit;



/******/
CREATE SEQUENCE adh_seq START WITH 100;
CREATE OR REPLACE TRIGGER adh_trg 
BEFORE INSERT ON adherent 
FOR EACH ROW

BEGIN
  SELECT adh_seq.NEXTVAL
  INTO   :new.noadh
  FROM   dual;
END;

/********************  Integrity Laws*****************/
