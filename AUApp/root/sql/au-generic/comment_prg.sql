-- Table: public.comment_prg

-- DROP TABLE public.comment_prg;

CREATE TABLE public.comment_prg
(
  id bigint NOT NULL, -- id - unique comment block
  program bigint, -- reference to program.id
  line_nr_from integer, -- start line for comment block
  line_nr_to integer, -- end line for comment block
  is_io_description boolean, -- true if this block is the business descriptor for the referenced input_output
  comment character varying(102400), -- Comment block - max. 100kB
  CONSTRAINT pk_comment_prg PRIMARY KEY (id),
  CONSTRAINT fk_comment_prg_program FOREIGN KEY (program)
      REFERENCES public.program (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION -- Foreign Key to table input_output
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.comment_prg
  OWNER TO au;
COMMENT ON TABLE public.comment_prg
  IS 'Comments related to program';
COMMENT ON COLUMN public.comment_prg.id IS 'id - unique comment block';
COMMENT ON COLUMN public.comment_prg.program IS 'reference to program.id';
COMMENT ON COLUMN public.comment_prg.line_nr_from IS 'start line for comment block';
COMMENT ON COLUMN public.comment_prg.line_nr_to IS 'end line for comment block';
COMMENT ON COLUMN public.comment_prg.is_io_description IS 'true if this block is the business descriptor for the referenced input_output ';
COMMENT ON COLUMN public.comment_prg.comment IS 'Comment block - max. 100kB';

COMMENT ON CONSTRAINT fk_comment_prg_program ON public.comment_prg IS 'Foreign Key to table program';


-- Index: public.fki_comment_prg_program

-- DROP INDEX public.fki_comment_prg_program;

CREATE INDEX fki_comment_prg_program
  ON public.comment_prg
  USING btree
  (program);

