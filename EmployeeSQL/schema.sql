-- SCHEMA: public

-- DROP SCHEMA public ;

CREATE SCHEMA public
    AUTHORIZATION postgres;

COMMENT ON SCHEMA public
    IS 'standard public schema';

GRANT ALL ON SCHEMA public TO PUBLIC;

GRANT ALL ON SCHEMA public TO postgres;


-- Table: public.departments

-- DROP TABLE public.departments;

CREATE TABLE IF NOT EXISTS public.departments
(
    dept_no character varying(4) COLLATE pg_catalog."default" NOT NULL,
    name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT department_pkey PRIMARY KEY (dept_no)
)

TABLESPACE pg_default;

ALTER TABLE public.departments
    OWNER to postgres;

-- Table: public.titles

-- DROP TABLE public.titles;

CREATE TABLE IF NOT EXISTS public.titles
(
    title_id character varying(5) COLLATE pg_catalog."default" NOT NULL,
    title character varying(25) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT titles_pkey PRIMARY KEY (title_id)
)

TABLESPACE pg_default;

ALTER TABLE public.titles
    OWNER to postgres;


-- Table: public.employees

-- DROP TABLE public.employees;

CREATE TABLE IF NOT EXISTS public.employees
(
    emp_no integer NOT NULL,
    emp_title character varying(5) COLLATE pg_catalog."default" NOT NULL,
    birth_date date NOT NULL,
    first_name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    sex character(1) COLLATE pg_catalog."default" NOT NULL,
    hire_date date NOT NULL,
    CONSTRAINT employees_pkey PRIMARY KEY (emp_no),
    CONSTRAINT fk_emp_title__titles_title_id FOREIGN KEY (emp_title)
        REFERENCES public.titles (title_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE public.employees
    OWNER to postgres;

-- Table: public.salaries

-- DROP TABLE public.salaries;

CREATE TABLE IF NOT EXISTS public.salaries
(
    emp_no integer NOT NULL,
    salary integer NOT NULL,
    CONSTRAINT salaries_pkey PRIMARY KEY (emp_no),
    CONSTRAINT fk_emp_no__employees_emp_no FOREIGN KEY (emp_no)
        REFERENCES public.employees (emp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.salaries
    OWNER to postgres;

-- Table: public.dept_manager

-- DROP TABLE public.dept_manager;

CREATE TABLE IF NOT EXISTS public.dept_manager
(
    dep_no character varying(4) COLLATE pg_catalog."default" NOT NULL,
    emp_no integer NOT NULL,
    CONSTRAINT ck_dept_manager__dep_emp PRIMARY KEY (dep_no, emp_no),
    CONSTRAINT fk_dept_no__departments_dept_no FOREIGN KEY (dep_no)
        REFERENCES public.departments (dept_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emp_no__employees_emp_no FOREIGN KEY (emp_no)
        REFERENCES public.employees (emp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.dept_manager
    OWNER to postgres;

-- Table: public.dept_emp

-- DROP TABLE public.dept_emp;

CREATE TABLE IF NOT EXISTS public.dept_emp
(
    dep_no character varying(4) COLLATE pg_catalog."default" NOT NULL,
    emp_no integer NOT NULL,
    CONSTRAINT ck_dept_emp__dep_emp PRIMARY KEY (emp_no, dep_no),
    CONSTRAINT fk_dept_no__departments_dept_no FOREIGN KEY (dep_no)
        REFERENCES public.departments (dept_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emp_no__employees_emp_no FOREIGN KEY (emp_no)
        REFERENCES public.employees (emp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.dept_emp
    OWNER to postgres;
