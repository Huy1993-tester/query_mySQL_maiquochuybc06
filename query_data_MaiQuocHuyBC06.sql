-- 5 nguoi dung lau nhat-- 
select * from users U 
order by created_at
limit 5;


-- tìm theo ngày trong tháng lượt đăng ký cao nhất  
select substring(U.created_at,1,10) formatDay ,dayname(U.created_at) ngày  , count(U.created_at) luot_dang_ky from users U 
group by substring(U.created_at,1,10)
order by luot_dang_ky desc;
-- tim theo thứ trong tuần lượt đăng ký cao nhất 
select substring(U.created_at,1,10) formatDay ,dayname(U.created_at) ngày  , count(U.created_at) luot_dang_ky from users U 
group by ngày
order by luot_dang_ky desc
limit 2;





-- user khong hoat dong--  
select * , count(*) from users U left join photos P
on U.id = P.user_id
where P.image_url is null;

-- img max like cao nhat va user post-- 
           
            select U.id ,U.username,U.created_at,P.id,P.image_url,P.user_id,P.created_at, count(L.user_id) tong_like from users U join photos	P 
            on U.id = P.user_id left join likes L 
            on P.id = L.photo_id
            group by P.id
            order by tong_like desc
			limit 1;

-- trung binh anh tren users--  

with A as ( select count(id)  so_luong_User from users )
select (count(P.id)/(select A.so_luong_User from A)) avg_img_1_user  from photos P;

-- tim user thuong duoc hashtags nhiu nhat--

select S.id, S.tag_name, S.created_at , count(S.tag_name) hash_tag from photos P left join photo_tags PT
on P.id = PT.photo_id left join tags S 
on PT.tag_id = S.id
group by S.tag_name
order by hash_tag desc
limit 5;

-- user da thich 1 buc anh--

use ig_clone;
with C as (
 select count(id) luot_like  from photos 
)
select U.id, U.username, U.created_at ,  ( case (select C.luot_like from C) when count(L.user_id)  then count(L.user_id) else 0 end)  slot_like_of_user
 from  photos P left join likes L 
on P.id = L.photo_id left join users U 
on L.user_id = U.id
group by L.user_id 
having slot_like_of_user > 0
order by slot_like_of_user desc






 
 
















