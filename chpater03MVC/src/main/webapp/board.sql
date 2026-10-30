create table board(
num int auto_increment primary key,
writer varchar(20),
email varchar(50),
subject varchar(50),
password varchar(10),
reg_date date,
ref int,
re_step int,
readcount int,
content varchar(1000),
id varchar(10)
);

INSERT INTO board (writer, email, subject, password, reg_date, ref, re_step, readcount, content, id) VALUES
('admin',  'admin@naver.com',  '공지사항입니다',        '1234', '2026-10-01', 1, 0, 25, '게시판 이용 규칙을 안내드립니다.',          'admin'),
('baek17', 'baek17@naver.com', '캠핑 장비 추천해주세요', '1717', '2026-10-03', 2, 0, 12, '초보자가 쓰기 좋은 텐트 추천 부탁드려요.',   'baek17'),
('choi05', 'choi05@naver.com', '주말 캠핑 후기',         '5555', '2026-10-05', 3, 0, 18, '가평으로 다녀왔는데 정말 좋았습니다.',       'choi05'),
('han10',  'han10@naver.com',  '요즘 읽는 책 공유해요',  '1010', '2026-10-08', 4, 0, 9,  '이번 달에 읽은 책 중 추천할 만한 책입니다.', 'han10'),
('hong01', 'hong01@naver.com', '영화 추천 부탁드립니다', '1111', '2026-10-10', 5, 0, 15, '최근 개봉한 영화 중 볼만한 것 있을까요?',   'hong01'),
('jang',   'kjb@naver.com',    '안녕하세요 가입인사',    '1111', '2026-10-12', 6, 0, 7,  '새로 가입했습니다. 잘 부탁드립니다.',        'jang'),
('jang19', 'jang19@naver.com', 'RE: 캠핑 장비 추천',     '1919', '2026-10-15', 2, 1, 4,  '저는 2인용 돔텐트를 추천드려요.',            'jang19'),
('jung06', 'jung06@naver.com', 'RE: 영화 추천',          '6666', '2026-10-18', 5, 1, 6,  '요즘 개봉작 중에 스릴러가 재미있습니다.',    'jung06'),
('kang07', 'kang07@naver.com', 'RE: 캠핑 장비 추천',     '7777', '2026-10-22', 2, 2, 3,  '장비는 대여해서 먼저 써보셔도 좋아요.',      'kang07'),
('kim03',  'kim03@naver.com',  '등산 영화 모임 후기',    '3333', '2026-10-27', 7, 0, 6,  '지난 모임 정말 즐거웠습니다. 감사합니다.',   'kim03');