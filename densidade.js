/*
* This file is parte of Strawberry, a html/js app for musical texture density
* planning released under the MIT license terms.
* Copyright (c) 2015 Raphael Sousa Santos, http://www.raphaelss.com
*/
"use strict";

function drh(density_number, ambitus, time) {
    return 100 * density_number / (ambitus * time);
}

function in_range(x, target) {
    if (x == target.value) {
        return "exact";
    }
    return x >= target.min && x <= target.max;
}

function solve_drh(target, var_spec) {
    var results = [];
    for(var time = var_spec.t_min; time <= var_spec.t_max; ++time) {
        for(var ambitus = var_spec.a_min; ambitus <= var_spec.a_max; ++ambitus) {
            for(var density_number = var_spec.da_min; density_number <= var_spec.da_max; ++density_number) {
                var x = drh(density_number, ambitus, time);
                var test = in_range(x, target);
                if (test && (time > 1 || ambitus >= density_number)) {
                    results.push({"drh": x, "da": density_number, "a": ambitus, "t": time, "exact": test == "exact"});
                }
            }
        }
    }
    return results;
}

function value(id) {
    return document.getElementById(id).valueAsNumber;
}

function make_target() {
    var target = value("target");
    var margin = value("target-margin");
    return {
        "value": target,
        "min": Math.max(0, target - margin),
        "max": Math.min(100, target + margin)
    };
}

function make_var_spec() {
    return {
        "da_min": value("da-min"),
        "da_max": value("da-max"),
        "a_min": value("a-min"),
        "a_max": value("a-max"),
        "t_min": value("t-min"),
        "t_max": value("t-max")
    };
}

function make_row(table, drh, da, a, t, exact) {
    var row = document.createElement("tr");
    table.appendChild(row);
    var drh_td = document.createElement("td");
    drh_td.innerHTML = drh.toFixed(2);
    row.appendChild(drh_td);
    var da_td = document.createElement("td");
    da_td.innerHTML = da;
    row.appendChild(da_td);
    var a_td = document.createElement("td");
    a_td.innerHTML = a;
    row.appendChild(a_td);
    var t_td = document.createElement("td");
    t_td.innerHTML = t;
    row.appendChild(t_td);
    if (exact) {
        row.className = "success";
    }
}

function write_results(table, results) {
    for (var x = 0; x != results.length; ++x) {
        var r = results[x];
        make_row(table, r.drh, r.da, r.a, r.t, r.exact);
    }
}

function delete_old_table() {
    var table = document.getElementById("result-table");
    if (table) {
        table.parentNode.removeChild(table);
    }
}

function make_table(results) {
    delete_old_table();
    var result_area = document.getElementById("result-area");
    var table = document.createElement("table");
    table.id = "result-table";
    table.className = "table table-hover table-bordered table-condensed";
    result_area.appendChild(table);
    var head = document.createElement("thead");
    table.appendChild(head);
    var tr = document.createElement("tr");
    head.appendChild(tr);
    var drh = document.createElement("th");
    tr.appendChild(drh);
    drh.innerHTML = "<abbr title=\"Densidade relativa horizontal\">Drh</abbr>";
    var da = document.createElement("th");
    da.innerHTML = "<abbr title=\"Densidade absoluta\">Da</abbr>";
    tr.appendChild(da);
    var a = document.createElement("th");
    a.innerHTML = "<abbr title=\"Âmbito\">A</abbr>";
    tr.appendChild(a);
    var t = document.createElement("th");
    t.innerHTML = "<abbr title=\"Tempo\">T</abbr>";
    tr.appendChild(t);
    var tbody = document.createElement("tbody");
    table.appendChild(tbody);
    write_results(tbody, results);
    return table;
}

function run() {
    var results = solve_drh(make_target(), make_var_spec());
    make_table(results);
    return false;
}
