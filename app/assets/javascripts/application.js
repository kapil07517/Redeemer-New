// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= jquery.rest

$(document).ready(function() {
    setTimeout(function() {
        $('#collexp-menu > li > div.expanded + ul').slideToggle('medium');
        $('#collexp-menu > li > div').click(function() {
            $('#collexp-menu > li > div.expanded').not(this).toggleClass('expanded').toggleClass('collapsed').parent().find('> ul').slideToggle('medium');
            $(this).toggleClass('expanded').toggleClass('collapsed').parent().find('> ul').slideToggle('medium');
        });
    }, 250);

    setTimeout(function() {
        // Slide
        $('#menu > li > a.expanded + ul').slideToggle('medium');
        $('#menu > li > a').click(function() {
            $(this).toggleClass('expanded').toggleClass('collapsed').parent().find('> ul').slideToggle('medium');
        });
        $('#leftColumn .expand_all').click(function() {
            $('#menu > li > a.collapsed').addClass('expanded').removeClass('collapsed').parent().find('> ul').slideDown('medium');
        });
        $('#leftColumn .collapse_all').click(function() {
            $('#menu > li > a.expanded').addClass('collapsed').removeClass('expanded').parent().find('> ul').slideUp('medium');
        });
    }, 250);

});

function update_room_status(id) {
    if ($("#room-status_" + id).is(':checked'))
    {
        var status = true;
    }
    else {
        var status = false;
    }
    $.ajax({
        url: "/admin/rooms/" + id + "/change_status",
        data: {
            "room_status": status,
            "room_id": id
        },
        type: "PUT",
        dataType: "script",
        success: function(data) {
        }
    })
}

function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).parent().before(content.replace(regexp, new_id));
    if ($(link).closest(".fields").length == '5') {
        return false;
    }
//    $('.fields input[type=file]').customFileInput();
}

function display_this(date, day, st) {
    $.ajax({
        url: "/counselor/dashboards/counselor_status",
        data: {
            date: date,
            day: day,
            status: st
        },
        method: "GET",
        dataType: 'script',
        success: function(data) {

        }
    })
}

function show_this_date_appointments(date) {
    var list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    if (date in list == true) {
        date = '0' + date;
        $("#appointments_" + date).show();
        $("a#show_this_" + date).replaceWith('<a onclick="show_this_date_appointments1(' + date + '); return false;" href="#" id="show_this_' + date + '" class="plus-minus-link">-</a>')
    } else {
        $("#appointments_" + date).show();
        $("a#show_this_" + date).replaceWith('<a onclick="show_this_date_appointments1(' + date + '); return false;" href="#" id="show_this_' + date + '" class="plus-minus-link">-</a>')
    }
}

function show_this_date_appointments1(date) {
    var list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    if (date in list == true) {
        date = '0' + date;
        $("#appointments_" + date).hide();
        $("a#show_this_" + date).replaceWith('<a onclick="show_this_date_appointments(' + date + '); return false;" href="#" id="show_this_' + date + '" class="plus-minus-link">+</a>')
    } else {
        $("#appointments_" + date).hide();
        $("a#show_this_" + date).replaceWith('<a onclick="show_this_date_appointments(' + date + '); return false;" href="#" id="show_this_' + date + '" class="plus-minus-link">+</a>')
    }
}

function display_invoice_form(role, case_id, counselor_id, client_id, appointment_id) {
    url = "/" + role + "/invoices/new";
    $.ajax({
        url: url,
        data: {
            role: role,
            appointment_id: appointment_id,
            client_id: client_id
        },
        type: 'GET',
        dataType: 'script',
        success: function(data) {

        }
    })
}

function change_status(th, cas) {
    var st = $(th).val();
    $.ajax({
        url: "/counselor/case_managements/" + cas,
        data: {
            status: st
        },
        type: 'PUT'
    });
}

function deselect(th) {
    $(".pop").slideFadeToggle(function() {
        $(th).removeClass("selected");
    });
}

function search_form(th, role, appointment) {
    if ($(th).hasClass("selected")) {
        deselect(th);
    } else {
        $(th).addClass("selected");
        $(".pop").slideFadeToggle(function() {
            $.ajax({
                url: "/" + role + "/client_managements/search_form",
                data: {
                    appointment_id: appointment
                },
                type: 'GET'
            });
        });
    }
}


$.fn.slideFadeToggle = function(easing, callback) {
    return this.animate({opacity: 'toggle', height: 'toggle'}, "fast", easing, callback);
};

function change_back(th) {
    $(th).css({"border": "1px solid #C1CDB1", "box-shadow": "4px 4px 4px #999999 inset"});
}

function update_invoice(invoice_id) {
    var copay = $("#copay_" + invoice_id).val();
    var uos = $("#uos_" + invoice_id).val();
    var paid = $("#paid_" + invoice_id).val();
    var payment = $("#payment_" + invoice_id).val();
    $.ajax({
        url: "/counselor/invoices/" + invoice_id + "/update_invoice",
        data: {
            invoice: {
                copay: copay,
                uos: uos,
                paid: paid,
                invoice_payment: payment
            }
        },
        type: 'PUT',
        dataType: 'script'
    });
}

function intake(th) {
    if ($(th).is(":checked")) {
        $("#intake_ids,#intake_id,#other_intakes").val($("#intake_ids").val() + $(th).val() + ",");
    } else {
        var pop_val = $("#intake_ids").val().replace($(th).val() + ",", "");
        $("#intake_ids,#intake_id,#other_intakes").val(pop_val);
    }
}

function display_intake_details(ele, intake_id) {
    $("input.unique").not(ele).attr("checked", false);
    if ($(ele).is(':checked')) {
        $("#intake_ids,#intake_id").val(intake_id + ',');
        $.ajax({
            url: "/intake_coordinator/dashboards/" + intake_id + "/details"
        });
    } else {
        $("#intake_ids,#intake_id,#other_intakes").val('');
        $("#intake_from_information").html('');
    }
}