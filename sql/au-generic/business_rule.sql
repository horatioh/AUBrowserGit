-- Table: public.business_rule

-- DROP TABLE public.business_rule;

CREATE TABLE public.business_rule
(
  flow bigint NOT NULL,
  name character varying(255),
  domain character varying(255),
  complexity integer,
  priority integer,
  relevant boolean,
  required boolean,
  comment character varying(1024),
  CONSTRAINT fk_br_flow FOREIGN KEY (flow)
      REFERENCES public.flow (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.business_rule
  OWNER TO au;

-- Index: public.fki_br_flow

-- DROP INDEX public.fki_br_flow;

CREATE INDEX fki_br_flow
  ON public.business_rule
  USING btree
  (flow);

