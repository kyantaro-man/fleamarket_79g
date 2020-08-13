document.addEventListener(
  "turbolinks:load",
  (e) => {
    Payjp.setPublicKey("pk_test_9b3541215dcbac5f4a34a127");
    const btn = document.getElementById("token");
    btn.addEventListener("click", (e) => {
      e.preventDefault();

      const card = {
        number: document.getElementById("card_number").value,
        cvc: document.getElementById("cvc").value,
        exp_month: document.getElementById("exp_month").value,
        exp_year: document.getElementById("exp_year").value,
      };

      Payjp.createToken(card, (status, response) => {
        if (status === 200) {
          $("#card_number").removeAttr("name");
          $("#cvc").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name");
          $("#token").append(
            $(`<input type="hidden" name="token">`).val(response.id)
          );
          document.inputForm.submit();
          alert("登録が完了しました");
        } else {
          $("#token").prop("disabled", false);
          alert("カード情報が正しくありません。");
        }
      });
    });
  },
  false
);
