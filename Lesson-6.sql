Task1
_________________________________________________________________________________________________________
select count(*), from_user_id, to_user_id from messages
where to_user_id = 1  and (from_user_id in (SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 1) AND status='approved'
  union
  SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 1) AND status='approved'))
group by from_user_id
order by count(*) desc
limit 1







Task2
_________________________________________________________________________________________________________
SELECT count(*) as total_likes FROM media as m WHERE id IN (
	SELECT id FROM media 
	WHERE user_id IN (
		SELECT * FROM (
			SELECT user_id FROM profiles ORDER by birthday DESC LIMIT 10
		) as user_id		
	)
)
;






Task3
_________________________________________________________________________________________________________
SELECT count(*) AS total, 

	(SELECT CASE (gender)
         WHEN 'm' THEN 'male'
         WHEN 'f' THEN 'female'
    END AS gender FROM profiles WHERE user_id=likes.id ) AS gender

    FROM likes
	GROUP BY gender