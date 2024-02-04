-- SQL-команды для создания таблиц

-- Table customers
CREATE TABLE IF NOT EXISTS public.customers
(
    customer_id character varying COLLATE pg_catalog."default" NOT NULL,
    company_name text COLLATE pg_catalog."default" NOT NULL,
    contact_name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT customers_pkey PRIMARY KEY (customer_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers
    OWNER to postgres;

-- Table employees
CREATE TABLE IF NOT EXISTS public.employees
(
    employee_id integer NOT NULL DEFAULT nextval('employees_employee_id_seq'::regclass),
    first_name character varying COLLATE pg_catalog."default" NOT NULL,
    last_name character varying COLLATE pg_catalog."default" NOT NULL,
    title character varying COLLATE pg_catalog."default" NOT NULL,
    birth_date date NOT NULL,
    notes text COLLATE pg_catalog."default",
    CONSTRAINT employees_pkey PRIMARY KEY (employee_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.employees
    OWNER to postgres;

-- Table orders
CREATE TABLE IF NOT EXISTS public.orders
(
    order_id integer NOT NULL DEFAULT nextval('orders_order_id_seq'::regclass),
    customer_id "char" NOT NULL,
    employee_id integer NOT NULL DEFAULT nextval('orders_employee_id_seq'::regclass),
    order_date date NOT NULL,
    ship_city character varying(200) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT orders_pkey PRIMARY KEY (order_id),
    CONSTRAINT customer_fk FOREIGN KEY (customer_id)
        REFERENCES public.customers (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT employee_fk FOREIGN KEY (employee_id)
        REFERENCES public.employees (employee_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.orders
    OWNER to postgres;