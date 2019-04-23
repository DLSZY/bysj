/*==============================================================*/
/* Table: admin                                                 */
/*==============================================================*/
create table admin
(
   id                   varchar(40) not null,
   usernane             varchar(20),
   password             varchar(20),
   primary key (id)
);


drop table if exists business;

/*==============================================================*/
/* Table: business                                              */
/*==============================================================*/
create table business
(
   id                   varchar(40) not null,
   username             varchar(20),
   password             varchar(20),
   name                 varchar(40),
   address              varchar(100),
   phone                varchar(11),
   registertime         date,
   start_price          decimal,
   distribution_fee     decimal,
   primary key (id)
);



/*==============================================================*/
/* Table: goods_cate                                            */
/*==============================================================*/
create table goods_cate
(
   id                   varchar(40) not null,
   name                 varchar(20),
   level                int,
   parent_id            varchar(40),
   primary key (id)
);

/*==============================================================*/
/* Table: goods_cateinstore                                     */
/*==============================================================*/
create table goods_cateinstore
(
   id                   varchar(40) not null,
   name                 varchar(20),
   business_id          varchar(40),
   primary key (id)
);

/*==============================================================*/
/* Table: goods                                                 */
/*==============================================================*/
create table goods
(
   id                   varchar(40) not null,
   business_is          varchar(40),
   cate_id              varchar(40),
   cateinstore_id       varchar(40),
   name                 varchar(20),
   price                decimal,
   img_url              varchar(100),
   descripiton          varchar(200),
   sale_count           int,
   primary key (id)
);

/*==============================================================*/
/* Table: reduce                                                */
/*==============================================================*/
create table reduce
(
   id                   varchar(40) not null,
   business_id          varchar(40),
   achieve_money        decimal,
   reduce_money         decimal,
   primary key (id)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   id                   varchar(40) not null,
   username             varchar(20),
   password             varchar(20),
   phone                varchar(11),
   img_url              varchar(100),
   register             date,
   lastlogintime        date,
   solt                 varchar(10),
   primary key (id)
);



/*==============================================================*/
/* Table: address                                               */
/*==============================================================*/
create table address
(
   id                   varchar(40) not null,
   name                 varchar(10),
   detail               varchar(100),
   phone                varchar(11),
   user_id              varchar(40),
   primary key (id)
);

/*==============================================================*/
/* Table: shop_cart                                             */
/*==============================================================*/
create table shop_cart
(
   id                   varchar(40) not null,
   goods_id             varchar(40),
   user_id              varchar(40),
   goods_count          int,
   primary key (id)
);

/*==============================================================*/
/* Table: order_master                                          */
/*==============================================================*/
create table order_master
(
   id                   varchar(40) not null,
   user_id              varchar(40),
   address_id           varchar(40),
   order_num            varchar(40),
   create_date          date,
   order_amount         decimal,
   status               int,
   user_remarks         varchar(40),
   pay_status           int,
   primary key (id)
);

/*==============================================================*/
/* Table: order_detail                                          */
/*==============================================================*/
create table order_detail
(
   id                   varchar(40) not null,
   order_id             varchar(40),
   goods_id             varchar(40),
   goods_count          int,
   primary key (id)
);

/*==============================================================*/
/* Table: comment                                               */
/*==============================================================*/
create table comment
(
   id                   varchar(40) not null,
   user_id              varchar(40),
   goods_id             varchar(40),
   business_id          varchar(40),
   content              varchar(200),
   goods_grade          int,
   package_grade        int,
   distribute_grade     int,
   createdate           date,
   primary key (id)
);


