-- Table: public.comment_io

-- DROP TABLE public.comment_io;

CREATE TABLE public.comment_io
(
  id bigint NOT NULL, -- id - unique comment block
  input_output bigint, -- reference to input_output.id
  line_nr_from integer, -- start line for comment block
  line_nr_to integer, -- end line for comment block
  is_io_description boolean, -- true if this block is the business descriptor for the referenced input_output
  comment character varying(102400), -- Comment block - max. 100kB
  CONSTRAINT pk_comment_io PRIMARY KEY (id),
  CONSTRAINT fk_comment_io_input_output FOREIGN KEY (input_output)
      REFERENCES public.input_output (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION -- Foreign Key to table input_output
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.comment_io
  OWNER TO au;
COMMENT ON TABLE public.comment_io
  IS 'Comments related to input_output';
COMMENT ON COLUMN public.comment_io.id IS 'id - unique comment block';
COMMENT ON COLUMN public.comment_io.input_output IS 'reference to input_output.id';
COMMENT ON COLUMN public.comment_io.line_nr_from IS 'start line for comment block';
COMMENT ON COLUMN public.comment_io.line_nr_to IS 'end line for comment block';
COMMENT ON COLUMN public.comment_io.is_io_description IS 'true if this block is the business descriptor for the referenced input_output ';
COMMENT ON COLUMN public.comment_io.comment IS 'Comment block - max. 100kB';

COMMENT ON CONSTRAINT fk_comment_io_input_output ON public.comment_io IS 'Foreign Key to table input_output';


-- Index: public.fki_comment_io_input_output

-- DROP INDEX public.fki_comment_io_input_output;

CREATE INDEX fki_comment_io_input_output
  ON public.comment_io
  USING btree
  (input_output);

