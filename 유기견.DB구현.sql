-- c:\DEV> sqlplus -s system/oracle < 김기범.유기견.DB구현.sql

--user---------------------------------------------------------------------
drop user kimgibeom cascade;


create user kimgibeom IDENTIFIED by kimgibeom default tablespace users;
grant resource, connect to kimgibeom;

--table---------------------------------------------------------------------
create table kimgibeom.users(
user_id varchar2(50) constraint users_uid_pk primary key,
password varchar2(50) constraint users_pw_nn not null,
name varchar2(50) constraint users_name_nn not null,
phone_number varchar2(50) constraint users_phone_nn not null,
e_mail varchar2(100) constraint users_email_nn not null,
reg_date date constraint users_regdate_nn not null
);


create table kimgibeom.dogs(
dog_num number(10) constraint dogs_num_pk primary key,
title  varchar2(100) constraint dogs_title_nn not null,
name varchar2(50) constraint dogs_name_nn not null,
age number(3) constraint dogs_age_ck check(age>0),
kind varchar2(50) constraint dogs_kind_nn not null,
weight number(3) constraint dogs_weight_nn not null constraint dogs_weight_ck check(weight>0),
gender varchar2(20) constraint dogs_gender_nn not null,
adoption_status varchar2(20) constraint dogs_adopt_nn not null,
entrance_date date constraint dogs_enterdate_nn not null,
content  varchar2(4000) constraint dogs_content_nn not null,
attach_name varchar2(1000)
);




create table kimgibeom.adopts(
adopt_num number(10) constraint adopts_adoptnum_nn not null,
user_id varchar2(50) ,
reg_date date constraint adopts_regdate_nn not null,
dog_num number(10),
constraint adopts_uidanddnum_pk primary key(user_id,dog_num),
constraint adopts_uid_fk foreign key(user_id) references kimgibeom.users(user_id) on delete cascade,
constraint adopts_dnum_fk foreign key(dog_num) references kimgibeom.dogs(dog_num) on delete cascade
);



create table kimgibeom.reports(
report_num number(10) constraint reports_num_pk primary key,
user_id varchar2(50) constraint reports_uid_fk references kimgibeom.users(user_id) on delete cascade,
title varchar2(100) constraint reports_title_nn not null,
content varchar2(4000) constraint reports_content_nn not null,
view_count number(10) constraint reports_viewcount_nn not null constraint reports_viewcount_ck check(view_count>0),
reg_date date constraint reports_regdate_nn not null,
attach_name varchar2(1000)
);



create table kimgibeom.report_replies(
report_reply_num number(10) constraint reportreplies_num_pk primary key,
report_num number(10)  constraint reportreplies_reportnum_fk references kimgibeom.reports(report_num) on delete cascade,
user_id varchar2(50) constraint reportreplies_uid_fk references kimgibeom.users(user_id) on delete cascade,
content varchar2(4000) constraint reportreplies_content_nn not null,
reg_date date constraint reportreplies_regdate_nn not null
);


create table kimgibeom.reviews(
review_num number(10) constraint reviews_num_pk primary key,
title varchar2(100) constraint reviews_title_nn not null,
content varchar2(4000) constraint reviews_content_nn not null,
reg_date date constraint reviews_regdate_nn not null,
attach_name varchar2(1000)
);


create table kimgibeom.review_replies(
review_reply_num number(10) constraint reviewreplies_num_pk primary key,
review_num number(10)  constraint reviewreplies_reviewnum_fk references kimgibeom.reviews(review_num) on delete cascade,
user_id varchar2(50) constraint reviewreplies_uid_fk references kimgibeom.users(user_id) on delete cascade,
content varchar2(4000) constraint reviewreplies_content_nn not null,
reg_date date constraint reviewreplies_regdate_nn not null
);



create table kimgibeom.donations(
donation_num number(10) constraint donations_num_pk primary key,
user_id varchar2(50) constraint donations_uid_fk references kimgibeom.users(user_id) on delete set null,
price number(15) constraint donations_price_nn not null constraint donations_price_ck check(price>0),
donation_date date constraint donations_date_nn not null
);


--sequence-------------------------------------
create sequence kimgibeom.dog_num_seq;
create sequence kimgibeom.adopt_num_seq;
create sequence kimgibeom.report_num_seq;
create sequence kimgibeom.reportreply_num_seq;
create sequence kimgibeom.review_num_seq;
create sequence kimgibeom.reviewreply_num_seq;
create sequence kimgibeom.donation_num_seq;

--insert----------------------------------------
insert into kimgibeom.users
values('user','user','user','010-1234-1234','kkb509@naver.com','2019-01-04');
insert into kimgibeom.users
values('admin','admin','admin','010-1234-1234','rlqja910@google.com','2019-01-04');



--commit---------------------------------------------------------------------------
commit;