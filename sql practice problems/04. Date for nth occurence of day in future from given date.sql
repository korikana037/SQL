-- write a query to provide date for nth occurence of sunday in future from given date

set @n=3;
set @given_date= '2022-01-01';

SELECT DATE_ADD(
    @given_date,
    INTERVAL (7 - DAYOFWEEK(@given_date) + 1 + 7 * (@n - 1)) DAY
) AS nth_sunday;


-- /* in our case since we are trying to identify a date based on Sunday, 
the value for the 3rd argument is 1, incase it was a Wednesday we will pass 4 instead of 1,
and likewise for Monday(2), Tuesday(3), Thursday(5), Friday(6), and Saturday(7) */