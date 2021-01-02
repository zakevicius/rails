$(document).ready(function () {
  let showError, stripeResponseHandler, submitHandler;

  showError = (e) => {
    if ($("#flash-message").size() < 1) {
      $("div.container.main div:first").append(
        '<div id="flash-messages"></div>'
      );
    }
    $("#flash-message").html(
      '<div class="alert alert-warning"><a class="close" data-dismiss="alert">x</a><div id="flash-alert">' +
        e +
        "</div></div>"
    );
    $(".alert").delay(5000).fadeOut(3000);
    return false;
  };

  stripeResponseHandler = (status, res) => {
    let token, $form;

    $form = $(".cc_form");

    if (res.error) {
      console.log(res.error.message);
      showError(res.error.message);
      $form.find("input[type-submit]").prop("disabled", false);
    } else {
      token = res.id;
      $("<input>")
        .attr({ type: "hidden", name: "payment[token]" })
        .val(token)
        .appendTo($form);
      $("[data-stripe=number]").remove();
      $("[data-stripe=cvc]").remove();
      $("[data-stripe=exp-year]").remove();
      $("[data-stripe=exp-month]").remove();
      $("[data-stripe=label]").remove();

      $form.get(0).submit();
    }

    return false;
  };

  submitHandler = (e) => {
    let $form = $(e.target);
    $form.find("input[type-submit").prop("disabled", true);

    if (Stripe) {
      Stripe.card.createToken($form, stripeResponseHandler);
    } else {
      showError(
        "Failed to load credit card processing functionality. Please reload this page in your browser."
      );
    }

    return false;
  };

  $(".cc_form").on("submit", submitHandler);
});
