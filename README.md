# Alannah Dowdall 
<p align="center">
Hi, I’m Alannah, your friendly neighbourhood maths fan. 
 Enthusiastic about most of life especially music, CrossFit & cuddling my husband. 
</p>


## ♾️ About Me ##
	
- Born & raised in __Manchester__ I love being a part of this city. 
- I am mad for guitar bands: Arctic Monkeys, Oasis, The Maccabees, Courteeners, Elbow, Nathaniel Rateliff & the Night Sweats, Caamp. I __strongly__ believe that Guy Garvey is a _genius_ & should be revered as one of the <ins>greatest songwriters of all time</ins>. 
- I ran my first (~~only?~~) marathon in 2024.
-  __Georg Cantor__ is my _dreamboat mathematician_, because I love all things $\infty\$ and his diagonal argument is deliciously elegant.
- I can recite $\pi$ to 115 decimal places but my true favourite number is __576__ because it doesn’t _feel_ like a square but it is.


<details>

<summary> The CAREER SWITCH Story </summary>

<br/>

As a maths teacher I have had tremendous fun trying to show teenagers the beauty and power of mathematics. 

Having climbed the education ladder as far as I’d like, I felt a window of opportunity to become a student again; to stretch myself, rather than my classes, to see what I can achieve.

On the recommendation of a Data Scientist friend, I tried the CFG kickstarter in SQL and I was hooked. 

Just over a year later, here I am on the path to becoming a Data Engineer at a company where I will have a truly positive impact on society - I couldn’t be more thrilled. __Thank you CFG!__

Our lord and saviour Dolly Parton teaches us...
> Find out who you are and do it on purpose.

Well Dolly, I am **_doing my best!_**
 
</details>

</details>

## 🧠 Learning to Code 

So far I have completed Kickstarter courses in SQL and Python. SQL is my <ins>favourite</ins> language because it feels like abstract organising which is very much my vibe. I enjoy working logically and doing maths with sets, so nesting subqueries, working out sequencing of clauses to retrieve the desired data or considering appropriate unions are all challenges that appeal to me.

<details>

<summary>
	SQL
</summary>

I designed my SQL project on the CrossFit Open - a fitness challenge I take part in at my gym each year. Here is an example of code I wrote to allow the female athletes to view their overall ranking after completing all three workouts.

```
CREATE VIEW Open_F AS
SELECT
	f1.Ath_id,
	f1.FName,
	f1.SName,
	f1.GName,
	f1.City,
	f1.Ranka1f,
	f2.Ranka2f,
	f3.Ranka3f,
	DENSE_RANK() OVER (ORDER BY f1.Ranka1f+f2.Ranka2f+f3.Ranka3f) AS Open_Rank
FROM
FWOD1 f1
LEFT JOIN
FWOD2 f2
ON f1.Ath_id=f2.Ath_id
LEFT JOIN
FWOD3 f3
ON f2.Ath_id=f3.Ath_id;
```
</details>
