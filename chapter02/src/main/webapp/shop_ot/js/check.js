// 회원등록 / 회원정보 수정 공통 유효성 검사 (폼 이름: frm)
function checkForm() {
  var f = document.frm;
  if (f.custname.value == "") { alert("회원성명이 입력되지 않았습니다!"); f.custname.focus(); return false; }
  if (f.phone.value == "")    { alert("회원전화가 입력되지 않았습니다!"); f.phone.focus(); return false; }
  if (f.address.value == "")  { alert("회원주소가 입력되지 않았습니다!"); f.address.focus(); return false; }
  if (f.joindate.value == "") { alert("가입일자가 입력되지 않았습니다!"); f.joindate.focus(); return false; }
  if (f.grade.value == "")    { alert("고객등급이 선택되지 않았습니다!"); f.grade.focus(); return false; }
  if (f.city.value == "")     { alert("도시코드가 입력되지 않았습니다!"); f.city.focus(); return false; }
  return true;
}

