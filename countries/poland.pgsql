------------------------------------------
------------------------------------------
-- <country> Holidays
-- https://pl.wikipedia.org/wiki/Dni_wolne_od_pracy_w_Polsce
------------------------------------------
------------------------------------------
--
CREATE OR REPLACE FUNCTION holidays.country(p_start_year INTEGER, p_end_year INTEGER)
RETURNS SETOF holidays.holiday
AS $$

DECLARE
	-- Month Constants
	JANUARY INTEGER := 1;
	FEBRUARY INTEGER := 2;
	MARCH INTEGER := 3;
	APRIL INTEGER := 4;
	MAY INTEGER := 5;
	JUNE INTEGER := 6;
	JULY INTEGER := 7;
	AUGUST INTEGER := 8;
	SEPTEMBER INTEGER := 9;
	OCTOBER INTEGER := 10;
	NOVEMBER INTEGER := 11;
	DECEMBER INTEGER := 12;
	-- Weekday Constants
	SUNDAY INTEGER := 0;
	MONDAY INTEGER := 1;
	TUESDAY INTEGER := 2;
	WEDNESDAY INTEGER := 3;
	THURSDAY INTEGER := 4;
	FRIDAY INTEGER := 5;
	SATURDAY INTEGER := 6;
	WEEKEND INTEGER[] := ARRAY[0, 6];
	-- Primary Loop
	t_years INTEGER[] := (SELECT ARRAY(SELECT generate_series(p_start_year, p_end_year)));
	-- Holding Variables
	t_year INTEGER;
	t_datestamp DATE;
	t_dt1 DATE;
	t_dt2 DATE;
	t_holiday holidays.holiday%rowtype;

BEGIN
	FOREACH t_year IN ARRAY t_years
	LOOP

		t_holiday.datestamp := make_date(t_year, JANUARY, 1);
		t_holiday.description := 'Nowy Rok';
		RETURN NEXT t_holiday;
		if year >= 2011:
			t_holiday.datestamp := make_date(t_year, JANUARY, 6);
			t_holiday.description := 'Święto Trzech Króli';
			RETURN NEXT t_holiday;

		e = easter(year)
		self[e] = 'Niedziela Wielkanocna'
		self[e + rd(days=1)] = 'Poniedziałek Wielkanocny'

		if year >= 1950:
			t_holiday.datestamp := make_date(t_year, MAY, 1);
			t_holiday.description := 'Święto Państwowe';
			RETURN NEXT t_holiday;
		if year >= 1919:
			t_holiday.datestamp := make_date(t_year, MAY, 3);
			t_holiday.description := 'Święto Narodowe Trzeciego Maja';
			RETURN NEXT t_holiday;

		self[e + rd(days=49)] = 'Zielone Świątki'
		self[e + rd(days=60)] = 'Dzień Bożego Ciała'

		t_holiday.datestamp := make_date(t_year, AUG, 15);
		t_holiday.description := 'Wniebowzięcie Najświętszej Marii Panny';
		RETURN NEXT t_holiday;

		t_holiday.datestamp := make_date(t_year, NOV, 1);
		t_holiday.description := 'Uroczystość Wszystkich świętych';
		RETURN NEXT t_holiday;
		if (1937 <= year <= 1945) or year >= 1989:
			t_holiday.datestamp := make_date(t_year, NOV, 11);
			t_holiday.description := 'Narodowe Święto Niepodległości';
			RETURN NEXT t_holiday;

		t_holiday.datestamp := make_date(t_year, DEC, 25);
		t_holiday.description := 'Boże Narodzenie (pierwszy dzień)';
		RETURN NEXT t_holiday;
		t_holiday.datestamp := make_date(t_year, DEC, 26);
		t_holiday.description := 'Boże Narodzenie (drugi dzień)';
		RETURN NEXT t_holiday;

	END LOOP;
END;

$$ LANGUAGE plpgsql;