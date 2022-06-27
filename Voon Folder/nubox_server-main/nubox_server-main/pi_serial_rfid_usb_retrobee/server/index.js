var mysql = require("mysql");
const express = require("express");
const cors = require("cors");
var bodyParser = require("body-parser");
const path = require("path");
const fs = require("fs");
var Busboy = require('busboy');
var inspect = require('util').inspect;

const app = express();
const port = 3000;

// TODO: Raspberry Pi
var imagePath = '/var/www/html/images/';
// TODO: Windows
// var imagePath = 'C:/xampp/htdocs/images';
// TODO: MACOS
// var imagePath = '/Users/voonyoonnam/.bitnami/stackman/machines/xampp/volumes/root/htdocs/images/';

// TODO: Raspberry Pi
var videoPath = '/var/www/html/videos/';
// TODO: Windows
// var videoPath = 'C:/xampp/htdocs/videos';
// TODO: MACOS
// var videoPath = '/Users/voonyoonnam/.bitnami/stackman/machines/xampp/volumes/root/htdocs/videos/';

//For all
const dbname = 'nubox_android';

// const dbname = 'android_nubox';

// Raspberry Pi
const dbConnectionParam = {
  host: 'localhost',
  user: 'admin',
  password: 'adminadmin',
  database: dbname,
};

// For MACOS
// const dbConnectionParam = {
//   host: '192.168.64.2',
//   user: 'admin123',
//   password: '',
//   database: dbname
// };

// Windows
// const dbConnectionParam = {
//   host: 'localhost',
//   user: 'admin123',
//   password: '',
//   database: dbname
// };

app.use(cors({ origin: true }));
app.use(bodyParser.json());
app.get("/", (req, res) => res.send("Hello World!"));

app.post('/getCredit', (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          if (results.length > 0) {
            credit = results[0].credit;
            refunding_status = results[0].refunding_status;
            connection.end();
            res.send({
              status: 'OK',
              credit: credit,
              refunding_status: refunding_status == 1
            });
          } else {
            connection.end();
            res.send({
              status: 'error'
            });
          }
        }
      });
    }
  });
});

app.post('/updateCredit', (req, res) => {
  const credit = req.body.credit;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          if (results.length > 0) {
            original_credit = results[0].credit;
            machine_id = results[0].machine_id;
            original_credit += credit;

            var query = "UPDATE db_setting SET ? WHERE machine_id = ?";
            var values = [{ credit: original_credit }, machine_id];

            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                console.log(errors);
                connection.end();
                res.send({
                  status: 'error'
                });
              } else {
                connection.end();
                res.send({
                  status: 'OK',
                })
              }
            });
          } else {
            connection.end();
            res.send({
              status: 'error'
            });
          }
        }
      });
    }
  });
});

app.post('/getMachineOperation', (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          })
        } else {
          if (results.length > 0) {
            res.send({
              status: 'OK',
              result: {
                mode: results[0].mode,
                machine_id: results[0].machine_id,
                api_key: results[0].api_key,
              },
            });
          } else {
            res.send({
              status: 'OK',
              result: "",
            });
          }
        }
      });
    }
  });
});

app.post("/getAllProduct", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_product";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
            result: results,
          })
        }
      });
    }
  });
});

app.post("/getGKashInfo", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
            username: results[0].gkash_username,
            password: results[0].gkash_pw,
          })
        }
      });
    }
  });
});

app.post('/updateMachineMode', (req, res) => {
  const machine_id = req.body.machine_id;
  const machine_mode = req.body.machine_mode;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "UPDATE db_setting SET ? WHERE machine_id = ?";
      var values = [{ mode: machine_mode }, machine_id];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
          })
        }
      });
    }
  });
})

app.post('/insertAppSetting', (req, res) => {
  const machine_id = req.body.machine_id;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "DELETE FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          res.send({
            status: 'error'
          });
        } else {
          var query = "INSERT INTO db_setting (id,machine_id,is_setting_changed,mode,is_pwp_enabled,main_lifter_enable,sub_lifter_enable) VALUES (?,?,?,?,?,?,?)";
          var values = [null, machine_id, 1, "online", false, false, false];
          connection.query(query, values, (errors, results, fields) => {
            if (errors) {
              console.log(errors);
              connection.end();
              res.send({
                status: 'error'
              });
            } else {
              connection.end();
              res.send({
                status: 'OK',
              })
            }
          });
        }
      });

    }
  });
});

app.post('/getAppSetting', (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
            result: results,
          })
        }
      });
    }
  });
});

app.post("/setupMachineTrayAndSlot", (req, res) => {
  const slot_list = req.body.slot_list;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      var promises1 = [];
      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_row_and_column";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject('error');
          } else {
            resolve('success');
          }
        });
      }));
      Promise.all(promises).then(() => {

        promises1.push(new Promise((resolve1, reject1) => {
          slot_list.forEach((item, index) => {
            var query = "INSERT INTO db_row_and_column (tray_number,slot_number,time_created) VALUES (?,?,?)";
            var values = [Number(item.tray_number), Number(item.slot_quantity), new Date()];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                reject1('error');
              } else {
                resolve1('success');
              }
            });
          })
        }));
        Promise.all(promises1).then(() => {
          connection.end();
          res.send({
            status: 'OK',
          });
        }).catch(error => {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        });

      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  });
});
app.post("/setupRowInMachine", (req, res) => {
  const in_machine_list = req.body.in_machine_list;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      var promises1 = [];

      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_row_in_machine";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject('error');
          } else {
            resolve('success');
          }
        });
      }));

      Promise.all(promises).then(() => {

        promises1.push(new Promise((resolve1, reject1) => {
          in_machine_list.forEach((item, index) => {
            var query = "INSERT INTO db_row_in_machine (tray_number,in_machine,date_modified) VALUES (?,?,?)";
            var values = [Number(item.tray_number), Number(item.in_machine), new Date()];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                reject1('error');
              } else {
                resolve1('success');
              }
            });
          })
        }));
        Promise.all(promises1).then(() => {
          connection.end();
          res.send({
            status: 'OK',
          });
        }).catch(error => {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        });

      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  });
});

app.post("/setupMachineTrayStep", (req, res) => {
  const step_list = req.body.step_list;
  const main_lifter_enable = req.body.main_lifter_enable;
  const sub_lifter_enable = req.body.sub_lifter_enable;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      var promises1 = [];
      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_row_step";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject('error');
          } else {
            resolve('success');
          }
        });
      }));
      promises.push(new Promise((resolve, reject) => {
        var query = "UPDATE db_setting SET ?";
        var values = [{ main_lifter_enable: main_lifter_enable, sub_lifter_enable: sub_lifter_enable }];
        connection.query(query, values, (errors, results, fields) => {
          if (errors) {
            reject('error');
          } else {
            resolve('success');
          }
        });
      }));

      Promise.all(promises).then(() => {

        promises1.push(new Promise((resolve1, reject1) => {
          step_list.forEach((item, index) => {
            var query = "INSERT INTO db_row_step (tray_number,step_distance,date_modified) VALUES (?,?,?)";
            var values = [Number(item.tray_number), Number(item.step_distance), new Date()];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                reject1('error');
              } else {
                resolve1('success');
              }
            });
          })
        }));
        Promise.all(promises1).then(() => {
          connection.end();
          res.send({
            status: 'OK'
          });
        }).catch(error => {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        });

      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  });
});

app.post("/updateLifterEnableList", (req, res) => {
  const main_lifter_enable = req.body.main_lifter_enable;
  const sub_lifter_enable = req.body.sub_lifter_enable;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "UPDATE db_setting SET ?";
      var values = [{ main_lifter_enable: main_lifter_enable, sub_lifter_enable: sub_lifter_enable }];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error',
            result: false
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
            result: true
          })
        }
      });
    }
  });
});

app.post("/setupTrayInWhichMachine", (req, res) => {
  const row_in_machine_list = req.body.row_in_machine_list;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      var promises1 = [];
      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_row_in_machine";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject('error');
          } else {
            resolve('success');
          }
        });
      }));
      Promise.all(promises).then(() => {

        promises1.push(new Promise((resolve1, reject1) => {
          row_in_machine_list.forEach((item, index) => {
            var query = "INSERT INTO db_row_in_machine (tray_number,in_machine,date_modified) VALUES (?,?,?)";
            var values = [Number(item.tray_number), Number(item.in_machine), new Date()];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                reject1('error');
              } else {
                resolve1('success');
              }
            });
          })
        }));
        Promise.all(promises1).then(() => {
          connection.end();
          res.send({
            status: 'OK'
          });
        }).catch(error => {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        });

      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  });
});

app.post("/setupMachinePwP", (req, res) => {
  const is_pwp_enabled = req.body.is_pwp_enabled;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      promises.push(new Promise((resolve, reject) => {
        var query = "UPDATE db_setting SET ?";
        var values = [{ is_pwp_enabled: is_pwp_enabled }];
        connection.query(query, values, (errors, results, fields) => {
          if (errors) {
            console.log(errors);
            reject('error');
          } else {
            resolve('success');
          }
        });
      }));
      Promise.all(promises).then(() => {
        connection.end();
        res.send({
          status: 'OK'
        });
      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  });
});

app.post("/getMachineTrayAndSlot", (req, res) => {

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    }
    else {
      var slot_list = [];

      var query = "SELECT * FROM db_row_and_column";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        } else {
          slot_list = results;
          connection.end();
          res.send({
            status: 'OK',
            slot_list: slot_list
          });
        }
      });
    }

  });
});

app.post("/getMotorCoordinate", (req, res) => {
  const motor_number = req.body.motor_number;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_product WHERE motor_number = ?";
      var values = [Number(motor_number)]
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        } else {
          slot_list = results;
          console.log(slot_list);
          connection.end();
          res.send({
            status: 'OK',
            tray_number: results[0].tray_number,
            slot_number: results[0].slot_number,
            drop_sensor: results[0].drop_sensor_enable,
            quarter_turn: results[0].quarter_turn_enable,
            continue_order: results[0].continue_order
          });
        }
      });
    }
  })
});
app.post("/getSubExist", (req, res) => {
  var is_sub_exist = false;
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT MAX(in_machine) FROM db_row_in_machine";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        } else {
          if (results[0]['MAX(in_machine)'] > 1) {
            is_sub_exist = true;
          }
          connection.end();
          res.send({
            status: 'OK',
            max_machine_number: results[0]['MAX(in_machine)'],
            is_sub_exist: is_sub_exist,
          });
        }
      });
    }
  })
});

app.post("/getRowInMachineList", (req, res) => {
  var row_in_machine_list = [];
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_row_in_machine";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        } else {
          results.forEach(item, index => {
            row_in_machine_list[index] = item.in_machine;
          })
          connection.end();
          res.send({
            status: 'OK',
            row_in_machine_list: row_in_machine_list,
          });
        }
      });
    }
  })
});
app.post("/getLifterEnableList", (req, res) => {
  var main_lifter_enable = false;
  var sub_lifter_enable = false;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          main_lifter_enable = results[0].main_lifter_enable == 1 ? true : false;
          sub_lifter_enable = results[0].sub_lifter_enable == 1 ? true : false;
          res.send({
            status: 'OK',
            main_lifter_enable: main_lifter_enable,
            sub_lifter_enable: sub_lifter_enable,
          });
        }
      });

    }
  })
});
app.post("/getLifterExist", (req, res) => {
  var is_main_lifter_exist = false;
  var is_sub_lifter_exist = false;
  var is_lifter_exist = false;
  var in_which_machine = 0;
  const row = req.body.row;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_row_in_machine WHERE tray_number = " + (row + 1);
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            console.log(errors);
            reject('error');
          } else {
            in_which_machine = results[0].in_machine;
            resolve('success');
          }
        });
      }));
      Promise.all(promises).then(() => {
        var query = "SELECT * FROM db_setting";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            connection.end();
            console.log(error);
            res.send({
              status: 'error'
            });
          } else {
            connection.end();
            is_main_lifter_exist = results[0].main_lifter_enable == 1 ? true : false;
            is_sub_lifter_exist = results[0].sub_lifter_enable == 1 ? true : false;
            if (in_which_machine == 1) {
              is_lifter_exist = is_main_lifter_exist;
            } else if (in_which_machine == 2) {
              is_lifter_exist = is_sub_lifter_exist;
            }
            res.send({
              status: 'OK',
              is_lifter_exist: is_lifter_exist,
            });
          }
        });
      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  })
});

app.post("/getAnyLifterExist", (req, res) => {
  var is_lifter_exist = false;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {

      var query = "SELECT * FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          is_lifter_exist = (results[0].main_lifter_enable || results[0].sub_lifter_enable == 1) ? true : false;
          res.send({
            status: 'OK',
            is_lifter_exist: is_lifter_exist,
          });
        }
      });
    }
  })
});

app.post("/setupLifterEnable", (req, res) => {
  const main_lifter_enable = req.body.main_lifter_enable;
  const sub_lifter_enable = req.body.sub_lifter_enable;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      promises.push(new Promise((resolve, reject) => {
        var query = "UPDATE db_setting SET ?";
        var values = [{ main_lifter_enable: main_lifter_enable, sub_lifter_enable: sub_lifter_enable }];
        connection.query(query, values, (errors, results, fields) => {
          if (errors) {
            console.log(errors);
            reject('error');
          } else {
            resolve('success');
          }
        });
      }));
      Promise.all(promises).then(() => {
        connection.end();
        res.send({
          status: 'OK'
        });
      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  });
});

app.post("/getRowSteps", (req, res) => {
  var step_each_row = []
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_row_step";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            console.log(errors);
            reject('error');
          } else {
            results.forEach((item, index) => {
              step_each_row[index] = item.step_distance;
            })
            resolve('success');
          }
        });
      }));
      Promise.all(promises).then(() => {
        connection.end();
        res.send({
          status: 'OK',
          step_each_row: step_each_row
        });
      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  });
});

app.post("/getSlotList", (req, res) => {
  var slot_list = []
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_row_and_column";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            console.log(errors);
            reject('error');
          } else {
            results.forEach((item, index) => {
              slot_list[index] = item.slot_number;
            })
            resolve('success');
          }
        });
      }));
      Promise.all(promises).then(() => {
        connection.end();
        res.send({
          status: 'OK',
          slot_list: slot_list
        });
      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  });
});

app.post("/getRowInWhichMachine", (req, res) => {
  var in_which_machine_list = []
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_row_in_machine";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            console.log(errors);
            reject('error');
          } else {
            results.forEach((item, index) => {
              in_which_machine_list[index] = item.in_machine;
            })
            resolve('success');
          }
        });
      }));
      Promise.all(promises).then(() => {
        connection.end();
        res.send({
          status: 'OK',
          in_which_machine_list: in_which_machine_list
        });
      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  });
});

app.post('/updateProductInfoFromSettingApp', (req, res) => {
  var product_detail_list = [];

  var busboy = new Busboy({
    headers: req.headers, limits: {
      fileSize: 100 * 1024 * 1024,
    }
  });

  var image_url_list = [];

  busboy.on('file', (fieldname, file, filename, encoding, mimetype) => {
    var motorLabel = filename.split('-')[0];
    console.log(filename);
    var saveToImage = path.join(imagePath, filename);
    // TODO: Change IP accordingly
    image_url_list.push({
      id: motorLabel,
      url: `http://192.168.0.2/images/${filename}`
    });

    file.pipe(fs.createWriteStream(saveToImage));

    file.on('data', (data) => {
    });
    file.on('end', () => {
    });
  });

  busboy.on('field', (fieldname, val, fieldnameTruncated, valTruncated, encoding, mimetype) => {
    if (fieldname == 'product_detail_list') {
      product_detail_list = inspect(val).replace(/'/g, "").replace(/`/g, "");
      product_detail_list = JSON.parse(product_detail_list);
    }
  });

  busboy.on('finish', () => {
    image_url_list.forEach(item => {
      console.log(item.url, "id", item.id);
    })
    product_detail_list.forEach(item => {
      var index = image_url_list.findIndex(x => x.id == item.motor_label);
      if (index < 0) {
        item.image_url = item.imageUrl;
      } else {
        console.log(index);
        item.image_url = image_url_list[index].url
      }
    });

    console.log(product_detail_list);
    var connection = mysql.createConnection(dbConnectionParam);

    connection.connect((error) => {
      if (error) {
        console.log("error connecting: " + error.stack);
        res.send({
          status: "error",
        });
      } else {
        var promises = [];
        product_detail_list.forEach(item => {
          promises.push(new Promise((resolve, reject) => {
            var query = "UPDATE db_product SET ? WHERE motor_label = ?";
            var values = [{ inventory: item.inventory, price: item.product_price, max_capacity: item.max_capacity, drop_sensor_enable: item.drop_sensor_enable, quarter_turn_enable: item.quarter_turn_enable, continue_order: item.continue_order, }, item.motor_label];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                reject(errors);
              } else {
                resolve("success");
              }
            });
          }))
        });

        Promise.all(promises).then(() => {
          res.send({
            status: 'OK'
          });
        }).catch(error => {
          res.send({
            status: 'error'
          });
        })
      }
    });
  });

  req.pipe(busboy);
});

app.post('/machineSyncUploadProductInfo', (req, res) => {
  // no motor calculation

  var product_detail_list = [];

  var busboy = new Busboy({
    headers: req.headers, limits: {
      fileSize: 100 * 1024 * 1024,
    }
  });

  var image_url_list = [];

  busboy.on('file', (fieldname, file, filename, encoding, mimetype) => {
    var motorLabel = filename.split('-')[0];
    console.log(filename);
    var saveToImage = path.join(imagePath, filename);
    // TODO: Change IP accordingly
    image_url_list.push({
      id: motorLabel,
      url: `http://192.168.0.2/images/${filename}`
    });

    file.pipe(fs.createWriteStream(saveToImage));

    file.on('data', (data) => {
    });
    file.on('end', () => {
    });
  });

  busboy.on('field', (fieldname, val, fieldnameTruncated, valTruncated, encoding, mimetype) => {
    if (fieldname == 'product_detail_list') {
      product_detail_list = inspect(val).replace(/'/g, "").replace(/`/g, "");
      console.log(product_detail_list);
      product_detail_list = JSON.parse(product_detail_list);
    }
  });

  busboy.on('finish', () => {
    // clean up and merge data
    // console.log(image_url_list);
    image_url_list.forEach(item => {
      console.log(item.url, "id", item.id);
    })
    product_detail_list.forEach(item => {
      var index = image_url_list.findIndex(x => x.id == item.motor_label);
      if (index < 0) {
        item.image_url = item.imageUrl;
      } else {
        console.log(index);
        item.image_url = image_url_list[index].url
      }
    });

    // console.log(product_detail_list);
    var connection = mysql.createConnection(dbConnectionParam);

    connection.connect((error) => {
      if (error) {
        console.log("error connecting: " + error.stack);
        res.send({
          status: "error",
        });
      } else {
        var promises = [];
        var promises1 = [];

        promises.push(new Promise((resolve, reject) => {
          var query = "DELETE FROM db_product";
          connection.query(query, (errors, results, fields) => {
            if (errors) {
              reject('error');
            } else {
              resolve('success');
            }
          });
        }));
        Promise.all(promises).then(() => {
          product_detail_list.forEach((resultsItem, resultIndex) => {
            promises1.push(new Promise((resolve1, reject1) => {
              // TODO: For family mart and NV
              var query = "INSERT INTO db_product (motor_number,created_date,price,product_name,motor_label,tray_number,slot_number,inventory,max_capacity,drop_sensor_enable,quarter_turn_enable,continue_order,product_image_url,second_pwp_price,third_pwp_price) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
              var values = [Number(resultsItem.motor_number), new Date(), parseFloat(resultsItem.product_price), resultsItem.product_name, resultsItem.motor_label, resultsItem.tray_number, resultsItem.slot_number, resultsItem.inventory, resultsItem.max_capacity, resultsItem.drop_sensor_enable, resultsItem.quarter_turn_enable, resultsItem.continue_order, resultsItem.image_url, resultsItem.second_pwp_price, resultsItem.third_pwp_price];
              // tray number and slot number terbalik because of firebase terbalik
              connection.query(query, values, (errors, results, fields) => {
                if (errors) {
                  console.log(errors);
                  reject1('error');
                } else {
                  resolve1('success');
                }
              });
            }));
          })

          Promise.all(promises1).then(() => {
            connection.end();
            res.send({
              status: 'OK'
            });

          }).catch(error => {
            connection.end();
            console.log(error);
            res.send({
              status: 'error1'
            });
          });

        }).catch(error => {
          connection.end();
          console.log(error);
          res.send({
            status: 'error1'
          });
        });

      }
    })

  });

  req.pipe(busboy);
});

app.post('/uploadProductInfo', (req, res) => {

  var product_detail_list = [];

  var busboy = new Busboy({
    headers: req.headers, limits: {
      fileSize: 100 * 1024 * 1024,
    }
  });

  var image_url_list = [];

  busboy.on('file', (fieldname, file, filename, encoding, mimetype) => {
    var motorLabel = filename.split('-')[0];
    console.log(filename);
    var saveToImage = path.join(imagePath, filename);
    // TODO: Change IP accordingly
    image_url_list.push({
      id: motorLabel,
      url: `http://192.168.0.2/images/${filename}`
    });

    file.pipe(fs.createWriteStream(saveToImage));

    file.on('data', (data) => {
    });
    file.on('end', () => {
    });
  });

  busboy.on('field', (fieldname, val, fieldnameTruncated, valTruncated, encoding, mimetype) => {
    if (fieldname == 'product_detail_list') {
      product_detail_list = inspect(val).replace(/'/g, "").replace(/`/g, "");
      console.log(product_detail_list);
      product_detail_list = JSON.parse(product_detail_list);
    }
  });

  busboy.on('finish', () => {
    // clean up and merge data
    // console.log(image_url_list);
    image_url_list.forEach(item => {
      console.log(item.url, "id", item.id);
    })
    product_detail_list.forEach(item => {
      var index = image_url_list.findIndex(x => x.id == item.motor_label);
      if (index < 0) {
        item.image_url = item.imageUrl;
      } else {
        console.log(index);
        item.image_url = image_url_list[index].url
      }
    });

    // console.log(product_detail_list);
    var connection = mysql.createConnection(dbConnectionParam);

    connection.connect((error) => {
      if (error) {
        console.log("error connecting: " + error.stack);
        res.send({
          status: "error",
        });
      } else {
        var promises = [];
        var promises1 = [];
        var row_and_column_list = [];
        var product_item_list = [];
        var image_url_list = [];
        var motor_quantity = 0;
        var motor_quantity_array = [];

        promises.push(new Promise((resolve, reject) => {
          var query = "DELETE FROM db_product";
          connection.query(query, (errors, results, fields) => {
            if (errors) {
              reject('error');
            } else {
              resolve('success');
            }
          });
        }));
        promises.push(new Promise((resolve, reject) => {
          var query = "SELECT * FROM db_row_and_column";
          connection.query(query, (errors, results, fields) => {
            if (errors) {
              reject('error');
            } else {
              temp_row_and_column_list = results;
              temp_row_and_column_list.forEach((item, index) => {
                row_and_column_list[item.tray_number - 1] = item
              })
              resolve('success');
            }
          });
        }));
        Promise.all(promises).then(() => {
          row_and_column_list.forEach((rowItem, rowIndex) => {
            for (var i = 1; i <= rowItem.slot_number; i++) {
              product_detail_list.forEach((resultsItem, resultIndex) => {
                if (Number(resultsItem.motor_number) == (i + Number(motor_quantity))) {
                  resultsItem.tray_number = rowItem.tray_number;
                  resultsItem.slot_number = resultIndex + 1 - motor_quantity;
                  resultsItem.motor_label = String.fromCharCode(64 + 6 + resultsItem.tray_number) + String(resultsItem.slot_number);
                }
              })
            }
            motor_quantity += rowItem.slot_number;
          })
          product_detail_list.forEach((resultsItem, resultIndex) => {
            promises1.push(new Promise((resolve1, reject1) => {

              var query = "INSERT INTO db_product (motor_number,created_date,price,product_name,motor_label,tray_number,slot_number,inventory,max_capacity,drop_sensor_enable,quarter_turn_enable,continue_order,product_image_url,second_pwp_price,third_pwp_price) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
              var values = [Number(resultsItem.motor_number), new Date(), parseFloat(resultsItem.product_price), resultsItem.product_name, resultsItem.motor_label, resultsItem.tray_number, resultsItem.slot_number, resultsItem.inventory, resultsItem.max_capacity, resultsItem.drop_sensor_enable, resultsItem.quarter_turn_enable, resultsItem.continue_order, resultsItem.image_url, resultsItem.second_pwp_price, resultsItem.third_pwp_price];
              connection.query(query, values, (errors, results, fields) => {
                if (errors) {
                  console.log(errors);
                  reject1('error');
                } else {
                  resolve1('success');
                }
              });
            }));
          })

          Promise.all(promises1).then(() => {
            connection.end();
            res.send({
              status: 'OK'
            });

          }).catch(error => {
            connection.end();
            console.log(error);
            res.send({
              status: 'error1'
            });
          });

        }).catch(error => {
          connection.end();
          console.log(error);
          res.send({
            status: 'error1'
          });
        });

      }
    })

  });

  req.pipe(busboy);
});

app.post("/setPaymentSelection", (req, res) => {
  const payment_list = req.body.payment_list;
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      var promises1 = [];
      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_payment_selection";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject('error');
          } else {
            resolve('success');
          }
        });
      }));
      Promise.all(promises).then(() => {

        promises1.push(new Promise((resolve1, reject1) => {
          var query = "INSERT INTO db_payment_selection (machine_id,cash_and_coin,wechat,grabpay,boost,alipay,gkash,qr_code,created_date) VALUES (?,?,?,?,?,?,?,?,?)";
          var values = [Number(payment_list.machine_id), Number(payment_list.cash_and_coin), Number(payment_list.wechat), Number(payment_list.grabpay), Number(payment_list.boost), Number(payment_list.alipay), Number(payment_list.gkash), Number(payment_list.qr_code), new Date()];
          connection.query(query, values, (errors, results, fields) => {
            if (errors) {
              reject1(errors);
            } else {
              resolve1('success');
            }
          });

        }));
        Promise.all(promises1).then(() => {
          connection.end();
          res.send({
            status: 'OK'
          });
        }).catch(error => {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        });

      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }

  })
});

app.post("/setPaymentSelection_v3", (req, res) => {
  const payment_list = req.body.payment_list;
  console.log("payment_list", payment_list);
  console.log("payment_list_key", Object.keys(payment_list));
  console.log("payment_list_values", Object.values(payment_list));
  console.log("payment_list_key", Object.keys(payment_list).length);
  console.log("payment", payment_list["Discount Card"]);

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises1 = [];

      Object.keys(payment_list).forEach((payElement, payIndex) => {
        console.log("key " + payElement);
        console.log("values " + Object.values(payment_list)[payIndex]);
        promises1.push(new Promise((resolve1, reject1) => {
          //TODO payment ID match with new part
          var query = "UPDATE db_select_payment SET ? WHERE name = ?";
          var values = [{ status: Object.values(payment_list)[payIndex] }, payElement];
          connection.query(query, values, (errors, results, fields) => {
            if (errors) {
              reject1(errors);
            } else {
              resolve1('success');
            }
          });

        }));
      })
      Promise.all(promises1).then(() => {
        connection.end();
        res.send({
          status: 'OK'
        });
      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });

    }

  })
});

app.post("/setPaymentSelectionV2", (req, res) => {
  const payment_list = req.body.payment_list;
  const machine_id = req.body.machine_id;
  var connection = mysql.createConnection(dbConnectionParam);

  var payment_array = [];
  var payment_value = [];
  for (var item in payment_list) {
    payment_array.push(item);
    payment_value.push(payment_list[item]);
  }
  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      var promises1 = [];
      var promises2 = [];
      promises.push(new Promise((resolve, reject) => {
        var query = " SELECT * FROM information_schema.tables WHERE table_schema = '" + dbname + "' AND table_name = 'db_payment_selection' LIMIT 1";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            console.log(errors);
            res.send({
              status: 'error'
            });
          } else {

            if (results.length == 0) {
              var query = "CREATE TABLE db_payment_selection (id INT AUTO_INCREMENT PRIMARY KEY, machine_id VARCHAR(255), created_date DATETIME)";
              connection.query(query, (errors1, results1, fields1) => {
                if (errors1) {
                  reject("error")
                } else {
                  resolve('success');
                }
              })
            }
            else {
              var query = "DROP TABLE db_payment_selection";
              connection.query(query, (errors, results, fields) => {
                if (errors) {
                  reject(errors);
                } else {
                  var query = "CREATE TABLE db_payment_selection (id INT AUTO_INCREMENT PRIMARY KEY, machine_id VARCHAR(255), created_date DATETIME)";
                  connection.query(query, (errors1, results1, fields1) => {
                    if (errors1) {
                      reject(errors1)
                    } else {
                      resolve('success');
                    }
                  })
                }
              });

            }
          }
        })

      }));
      Promise.all(promises).then(() => {
        promises1.push(new Promise((resolve1, reject1) => {

          var query = "INSERT INTO db_payment_selection (machine_id,created_date) VALUES (?,?)";
          var values = [machine_id, new Date()];
          connection.query(query, values, (errors, results, fields) => {
            if (errors) {
              reject1(errors);
            } else {
              resolve1('success');
            }
          });

        }));

        promises1.push(new Promise((resolve1, reject1) => {
          payment_array.forEach(item => {
            var query = "ALTER TABLE db_payment_selection ADD " + item + " INT(1)";
            var values = [item];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                reject1(errors);
              } else {
                resolve1('success');
              }
            });
          })
        }));
        Promise.all(promises1).then(() => {
          payment_array.forEach((item, index) => {
            promises2.push(new Promise((resolve2, reject2) => {
              var query = "UPDATE db_payment_selection SET " + item + " = " + String(payment_value[index]) + " WHERE machine_id = ?";
              var values = [machine_id];
              connection.query(query, values, (errors, results, fields) => {
                if (errors) {
                  reject2(errors);
                } else {
                  resolve2('success');
                }
              });

            }))
          })
          Promise.all(promises2).then(() => {
            connection.end();
            res.send({
              status: 'OK'
            });

          }).catch(error => {
            connection.end();
            console.log(error);
            res.send({
              status: error
            });
          });


        }).catch(error => {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        });

      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }

  })
});

app.post("/deletePromotionImage", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "DELETE FROM db_promotion_image";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(errors);
          res.send({
            status: "error",
          });
        } else {
          connection.end();
          res.send({
            status: 'OK'
          });
        }
      });
    }
  })
});

app.post("/deleteSplashScreenImage", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "DELETE FROM db_splash_screen_image";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(errors);
          res.send({
            status: "error",
          });
        } else {
          var query = "INSERT INTO db_splash_screen_image (id,image_url) VALUES (?,?)";
          var values = [null, null];
          connection.query(query, values, (errors, results, fields) => {
            if (errors) {
              connection.end();
              console.log(errors);
              res.send({
                status: "error",
              });
            } else {
              connection.end();
              console.log("DONE");
              res.send({
                status: "OK",
              });
            }
          });
        }
      });
    }
  })
});

app.post("/setMotorError", (req, res) => {
  console.log("setMotorError");
  const error_list = req.body.error_list;
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "INSERT INTO db_motor_diagnose (motor_number,motor_jammed,quarter_jammed,event_time) VALUES (?,?,?,?)";
      var values = [Number(error_list.motor_number), Number(error_list.motor_jammed), Number(error_list.quarter_jammed), new Date()];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(errors);
          res.send({
            status: "error",
          });
        } else {
          connection.end();
          res.send({
            status: 'OK'
          });
        }
      });
    }
  })
});

app.post("/deleteMotorError", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "DELETE FROM db_motor_diagnose";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(errors);
          res.send({
            status: "error",
          });
        } else {
          connection.end();
          res.send({
            status: 'OK'
          });
        }
      });
    }
  })
});

app.post("/modifyItemPrice", (req, res) => {
  const price_list = req.body.price_list;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises1 = [];
      price_list.forEach((priceItem, priceIndex) => {
        promises1.push(new Promise((resolve1, reject1) => {
          var query = "UPDATE db_product SET ? WHERE motor_number = ?";
          var values = [{ price: priceItem.price }, priceItem.motor_number];
          connection.query(query, values, (errors, results, fields) => {
            if (errors) {
              reject1('error');
            } else {
              resolve1('success');
            }
          });
        }))
      })
      Promise.all(promises1).then(() => {
        connection.end();
        res.send({
          status: 'OK'
        });

      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error1'
        });
      });

    }
  });
});

app.post("/replenishmentDone", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);
  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];

      var query = "SELECT * FROM db_product";
      connection.query(query, (errors, results, fields) => {
        if (errors) {

          console.log(errors);
          res.send({
            status: 'error'
          });
        } else {
          results.forEach((resultItem, resultIndex) => {
            promises.push(new Promise((resolve, reject) => {
              var query = "UPDATE db_product SET ? WHERE motor_number = ?";
              var values = [{ inventory: resultItem.max_capacity }, resultItem.motor_number];
              connection.query(query, values, (errors, results, fields) => {
                if (errors) {
                  reject('error');
                } else {
                  resolve('success');
                }
              });
            }))
          })
          Promise.all(promises).then(() => {
            connection.end();
            res.send({
              status: 'OK'
            });

          }).catch(error => {
            connection.end();
            console.log(error);
            res.send({
              status: 'error1'
            });
          });
        }
      });
    }
  })
});

app.post("/reduceItemQuantity", (req, res) => {
  const motor_number = req.body.motor_number;
  var connection = mysql.createConnection(dbConnectionParam);
  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_product WHERE motor_number = ?";
      var values = [motor_number];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          res.send({
            status: 'error'
          });
        } else {
          if (results[0].inventory > 0) {
            var query = "UPDATE db_product SET ? WHERE motor_number = ?";
            var values = [{ inventory: results[0].inventory - 1 }, motor_number];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                connection.end();
                console.log(error);
                res.send({
                  status: 'error1'
                });
              } else {
                connection.end();
                res.send({
                  status: 'OK'
                });
              }
            });
          } else {
            connection.end();
            res.send({
              status: 'OK'
            });
          }


        }
      });
    }
  })
});

app.post("/uploadTemperature", (req, res) => {
  const temperature = req.body.temperature;
  var connection = mysql.createConnection(dbConnectionParam);
  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "INSERT INTO db_sensor_data (temperature,event_time) VALUES (?,?)";
      var values = [parseFloat(temperature), new Date()];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
          })
        }
      });
    }
  })
});

app.post("/uploadDoorSensor", (req, res) => {
  const door_sensor = req.body.door_sensor;
  var connection = mysql.createConnection(dbConnectionParam);
  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "INSERT INTO db_sensor_data (door_sensor,event_time) VALUES (?,?)";
      var values = [door_sensor, new Date()];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
          })
        }
      });
    }
  })
});

app.post('/uploadSleepVideo', (req, res) => {

  var busboy = new Busboy({
    headers: req.headers, limits: {
      fileSize: 100 * 1024 * 1024,
    }
  });

  var url;

  var fstream;
  var result = [];
  var counter = 0;

  busboy.on('file', (fieldname, file, filename, encoding, mimetype) => {
    counter++;
    console.log(filename);
    var saveToVideo = path.join(videoPath, filename);
    // TODO: Change IP accordingly
    url = `http://192.168.0.2/videos/${filename}`
    console.log("Uploading: ", filename);

    fstream = fs.createWriteStream(saveToVideo);
    file.pipe(fstream);

    fstream.on('close', () => {
      counter--;
      console.log("Upload finished of " + filename);
      result.push(url);
      console.log("result", result);
      if (counter == 0) {
        console.log("writing finished");
        var connection = mysql.createConnection(dbConnectionParam);

        connection.connect((error) => {
          if (error) {
            console.log("error connecting: " + error.stack);
            res.send({
              status: "error",
            });
          } else {
            var query = "DELETE FROM db_ads_video WHERE type = ?";
            var values = ["full"]
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                connection.end();
                res.send({
                  status: "error",
                });
              } else {
                var query = "INSERT INTO db_ads_video (id,video_url,type) VALUES (?,?,?)";
                var values = [null, url, "full"];
                connection.query(query, values, (errors, results, fields) => {
                  if (errors) {
                    connection.end();
                    res.send({
                      status: "error from sleep",
                    });
                  } else {
                    connection.end();
                    res.send({
                      status: "OK",
                    });
                  }
                });
              }
            });
          }
        });
      }
    });

    file.on('data', (data) => {
    });
    file.on('end', () => {
    });
  });

  busboy.on('field', (fieldname, val, fieldnameTruncated, valTruncated, encoding, mimetype) => {
  });

  busboy.on('finish', () => {
    console.log('finish sleep');
  });

  req.pipe(busboy);
});

app.post('/uploadSplashScreenImage', (req, res) => {

  var busboy = new Busboy({
    headers: req.headers, limits: {
      fileSize: 100 * 1024 * 1024,
    }
  });

  var url;

  busboy.on('file', (fieldname, file, filename, encoding, mimetype) => {

    console.log(filename);
    var saveToImage = path.join(imagePath, filename);
    // TODO: Change IP accordingly
    url = `http://192.168.0.2/images/${filename}`

    file.pipe(fs.createWriteStream(saveToImage));

    file.on('data', (data) => {
    });
    file.on('end', () => {
    });
  });

  busboy.on('field', (fieldname, val, fieldnameTruncated, valTruncated, encoding, mimetype) => {
  });

  busboy.on('finish', () => {
    var connection = mysql.createConnection(dbConnectionParam);

    connection.connect((error) => {
      if (error) {
        console.log("error connecting: " + error.stack);
        res.send({
          status: "error",
        });
      } else {
        var query = "DELETE FROM db_splash_screen_image";

        connection.query(query, (errors, results, fields) => {
          if (errors) {
            connection.end();
            console.log(errors);
            res.send({
              status: "error",
            });
          } else {
            var query = "INSERT INTO db_splash_screen_image (id,image_url) VALUES (?,?)";
            var values = [null, url];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                connection.end();
                console.log(errors);
                res.send({
                  status: "error",
                });
              } else {
                connection.end();
                console.log("DONE");
                res.send({
                  status: "OK",
                });
              }
            });
          }
        });
      }
    });
  });

  req.pipe(busboy);
});

app.post('/uploadPromotionImage', (req, res) => {

  var busboy = new Busboy({
    headers: req.headers, limits: {
      fileSize: 100 * 1024 * 1024,
    }
  });

  var url;

  busboy.on('file', (fieldname, file, filename, encoding, mimetype) => {

    console.log(filename);
    console.log(mimetype);
    var saveToImage = path.join(imagePath, filename);
    // TODO: Change IP accordingly
    url = `http://192.168.0.2/images/${filename}`

    file.pipe(fs.createWriteStream(saveToImage));

    file.on('data', (data) => {
    });
    file.on('end', () => {
    });
  });

  busboy.on('field', (fieldname, val, fieldnameTruncated, valTruncated, encoding, mimetype) => {
  });

  busboy.on('finish', () => {
    var connection = mysql.createConnection(dbConnectionParam);

    connection.connect((error) => {
      if (error) {
        console.log("error connecting: " + error.stack);
        res.send({
          status: "error",
        });
      } else {
        var query = "DELETE FROM db_promotion_image";

        connection.query(query, (errors, results, fields) => {
          if (errors) {
            console.log(errors);
            connection.end();
            res.send({
              status: "error",
            });
          } else {
            var query = "INSERT INTO db_promotion_image (id,image_url) VALUES (?,?)";
            var values = [null, url];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                connection.end();
                console.log(errors);
                res.send({
                  status: "error",
                });
              } else {
                connection.end();
                console.log("DONE");
                res.send({
                  status: "OK",
                });
              }
            });
          }
        });
      }
    });
  });

  req.pipe(busboy);
});

app.post('/uploadBannerAdsVideo', (req, res) => {

  var busboy = new Busboy({
    headers: req.headers, limits: {
      fileSize: 100 * 1024 * 1024,
    }
  });

  var url;

  var fstream;
  var result = [];
  var counter = 0;

  busboy.on('file', (fieldname, file, filename, encoding, mimetype) => {
    counter++;
    console.log(filename);
    var saveToVideo = path.join(videoPath, filename);
    // TODO: Change IP accordingly
    url = `http://192.168.0.2/videos/${filename}`
    console.log("Uploading: ", filename);

    fstream = fs.createWriteStream(saveToVideo);
    file.pipe(fstream);

    fstream.on('close', () => {
      counter--;
      console.log("Upload finished of " + filename);
      result.push(url);
      console.log("result", result);
      if (counter == 0) {
        console.log("writing finished");
        var connection = mysql.createConnection(dbConnectionParam);

        connection.connect((error) => {
          if (error) {
            console.log("error connecting: " + error.stack);
            res.send({
              status: "error",
            });
          } else {
            var query = "DELETE FROM db_ads_video WHERE type = ?";
            var values = ["banner"]
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                console.log(errors);
                connection.end();
                res.send({
                  status: "error",
                });
              } else {
                var query = "INSERT INTO db_ads_video (id,video_url,type) VALUES (?,?,?)";
                var values = [null, result[0], "banner"];
                connection.query(query, values, (errors, results, fields) => {
                  if (errors) {
                    connection.end();
                    console.log(errors);
                    res.send({
                      status: "error from banner",
                    });
                  } else {
                    connection.end();
                    res.send({
                      status: "OK",
                    });
                  }
                });
              }
            });
          }
        });
      }
    });

    file.on('data', (data) => {
    });
    file.on('end', () => {
    });
  });

  busboy.on('field', (fieldname, val, fieldnameTruncated, valTruncated, encoding, mimetype) => {
  });

  busboy.on('finish', () => {

  });

  req.pipe(busboy);
});

app.post("/recoverySetup", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      //step 2
      var query = "SELECT * FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          res.send({
            status: 'error'
          });
        } else {
          if (results.length == 0 || (results.length > 0 && (results[0].mode == "" || results[0].mode == undefined || results[0].mode == null))) {
            connection.end();
            res.send({
              status: 'Not Completed',
              result: "Step 2",
              machine_id: results[0].machine_id,
            })
          } else {
            //step 3
            var query = "SELECT * FROM db_row_and_column ";
            connection.query(query, (errors, results, fields) => {
              if (errors) {
                console.log(errors);
                res.send({
                  status: 'error'
                });
              } else {
                if (results.length == 0) {
                  connection.end();
                  res.send({
                    status: 'Not Completed',
                    result: "Step 3",
                  })
                } else {
                  // step 4
                  var query = "SELECT * FROM db_product ";
                  connection.query(query, (errors, results, fields) => {
                    if (errors) {
                      console.log(errors);
                      res.send({
                        status: 'error'
                      });
                    } else {
                      if (results.length == 0) {
                        connection.end();
                        res.send({
                          status: 'Not Completed',
                          result: "Step 3",
                        })
                      } else {

                        var query = " SELECT * FROM information_schema.tables WHERE table_schema = '" + dbname + "' AND table_name = 'db_payment_selection' LIMIT 1";
                        connection.query(query, (errors, results, fields) => {
                          if (errors) {
                            console.log(errors);
                            res.send({
                              status: 'error'
                            });
                          } else {

                            if (results.length == 0) {
                              connection.end();
                              res.send({
                                status: 'Not Completed',
                                result: "Step 5",
                              })
                            }
                            else {
                              //step 6
                              var query = "SELECT * FROM db_payment_selection ";
                              connection.query(query, (errors, results, fields) => {

                                if (errors) {
                                  console.log(errors);
                                  res.send({
                                    status: 'error'
                                  });
                                } else {
                                  if (results.length == 0) {
                                    connection.end();
                                    res.send({
                                      status: 'Not Completed',
                                      result: "Step 5",
                                    })
                                  } else {
                                    if (Object.keys(results[0]).length <= 3) {
                                      connection.end();
                                      res.send({

                                        status: 'Not Completed',
                                        result: "Step 5",
                                      })
                                    } else {
                                      var query = "SELECT * FROM db_ads_video ";
                                      connection.query(query, (errors, results, fields) => {
                                        if (errors) {
                                          console.log(errors);
                                          res.send({
                                            status: 'error'
                                          });
                                        } else {
                                          if (results.length == 0) {
                                            connection.end();
                                            res.send({
                                              status: 'Not Completed',
                                              result: "Step 6",
                                            })
                                          } else {
                                            connection.end();
                                            res.send({
                                              status: 'OK',

                                            });
                                          }
                                        }
                                      });
                                    }

                                  }

                                }
                              });

                            }
                          }
                        });
                      }
                    }
                  });
                }
              }
            });
          }
        }
      });
    }
  });
});

app.post("/recoverySetup_v2", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      // step 4
      var query = "SELECT * FROM db_product";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          res.send({
            status: 'error'
          });
        } else {
          if (results.length == 0) {
            connection.end();
            res.send({
              status: 'Not Completed',
              result: "Step 4",
            })
          } else {
            //step 5
            var query = "SELECT * FROM db_select_payment";
            connection.query(query, (errors, results, fields) => {

              if (errors) {
                console.log(errors);
                res.send({
                  status: 'error'
                });
              } else {
                if (results.length == 0) {
                  connection.end();
                  res.send({
                    status: 'Not Completed',
                    result: "Step 5",
                  })
                } else {
                  if (Object.keys(results[0]).length <= 3) {
                    connection.end();
                    res.send({
                      status: 'Not Completed',
                      result: "Step 5",
                    })
                  } else {
                    var query = "SELECT * FROM db_ads_video ";
                    connection.query(query, (errors, results, fields) => {
                      if (errors) {
                        console.log(errors);
                        res.send({
                          status: 'error'
                        });
                      } else {
                        if (results.length == 0) {
                          connection.end();
                          res.send({
                            status: 'Not Completed',
                            result: "Step 6",
                          })
                        } else {
                          var query = "SELECT * FROM db_setting";
                          connection.query(query, (errors, results, fields) => {
                            if (errors) {
                              console.log(errors);
                              res.send({
                                status: 'error'
                              });
                            } else {
                              connection.end();
                              console.log(results)
                              res.send({
                                status: 'OK',
                                machine_id: results[0].machine_id,
                                mode: results[0].mode,
                                is_setting_changed: results[0].is_setting_changed,
                              });
                            }
                          });
                        }
                      }
                    });
                  }

                }

              }
            });

          }
        }
      });

    }
  });
});

app.post("/getMachineAllInfo", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      var lifter_enable_list = [];

      var machine_id, mode, is_pwp_enabled, api_key;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_setting";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            machine_id = results[0].machine_id;
            mode = results[0].mode;
            is_pwp_enabled = results[0].is_pwp_enabled == 1;
            lifter_enable_list = { main_lifter_enable: results[0].main_lifter_enable, sub_lifter_enable: results[0].sub_lifter_enable }
            api_key = results[0].api_key;
            console.log(results[0].api_key);
            resolve("success");
          }
        });
      }));

      var product_info;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_product";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            product_info = results;
            resolve("success");
          }
        });
      }));

      var faulty_selection;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_motor_diagnose";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            faulty_selection = results;
            resolve("success");
          }
        });
      }));

      var payment_selection;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_payment_selection";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            payment_selection = results[0];
            resolve("success");
          }
        });
      }));

      var tray_slot_info;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_row_and_column";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            tray_slot_info = results;
            resolve("success");
          }
        });
      }));
      var tray_step_info;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_row_step";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            tray_step_info = results;
            resolve("success");
          }
        });
      }));
      var tray_in_machine_info;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_row_in_machine";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            tray_in_machine_info = results;
            resolve("success");
          }
        });
      }));

      var sleep_ads_url, banner_ads_url;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_ads_video";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            results.forEach(item => {
              if (item.type == 'banner') {
                banner_ads_url = item.video_url;
              } else if (item.type == 'full') {
                sleep_ads_url = item.video_url;
              }
            });
            resolve("success");
          }
        });
      }));

      var promotion_image_url = "";
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_promotion_image";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            if (results.length > 0) {
              promotion_image_url = results[0].image_url;
            }
            resolve("success");
          }
        });
      }));

      var splashscreen_image_url = "";
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_splash_screen_image";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            splashscreen_image_url = results[0].image_url;
            resolve("success");
          }
        });
      }));

      var usb_port_config = "";
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_usb_configuration";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            usb_port_config = results;
            resolve("success");
          }
        });
      }));

      Promise.all(promises).then(() => {

        faulty_selection.forEach(item => {
          var index = product_info.findIndex(x => x.motor_number == item.motor_number);
          if (index > -1) {
            product_info[index].status = "Stop Sales";
          }
        });
        product_info.forEach(item => {
          if (item.status == null) {
            item.status = "Normal";
          }
        });
        connection.end();
        res.send({
          status: 'OK',
          machine_id: machine_id,
          mode: mode,
          is_pwp_enabled: is_pwp_enabled,
          api_key: api_key,
          tray_slot_info: tray_slot_info,
          tray_step_info: tray_step_info,
          tray_in_machine_info: tray_in_machine_info,
          payment_selection: payment_selection,
          lifter_enable_list: lifter_enable_list,
          product_info: product_info,
          sleep_ads_url: sleep_ads_url,
          banner_ads_url: banner_ads_url,
          promotion_image_url: promotion_image_url,
          splashscreen_image_url: splashscreen_image_url,
          usb_port_config: usb_port_config
        });
      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  });
});

app.post("/getMachineAllInfo_v2", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];

      var machine_id, mode;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_setting";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            machine_id = results[0].machine_id;
            mode = results[0].mode;
            resolve("success");
          }
        });
      }));

      var product_info;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_product";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            product_info = results;
            resolve("success");
          }
        });
      }));

      var faulty_selection;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_motor_diagnose";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            faulty_selection = results;
            resolve("success");
          }
        });
      }));

      var payment_selection;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_select_payment";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            payment_selection = results;
            resolve("success");
          }
        });
      }));

      var tray_slot_info;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_row_and_column";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            tray_slot_info = results;
            resolve("success");
          }
        });
      }));

      var sleep_ads_url, banner_ads_url;
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_ads_video";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            results.forEach(item => {
              if (item.type == 'banner') {
                banner_ads_url = item.video_url;
              } else if (item.type == 'full') {
                sleep_ads_url = item.video_url;
              }
            });
            resolve("success");
          }
        });
      }));

      var promotion_image_url = "";
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_promotion_image";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            if (results.length > 0) {
              promotion_image_url = results[0].image_url;
            }
            resolve("success");
          }
        });
      }));

      var splashscreen_image_url = "";
      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_splash_screen_image";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors)
          } else {
            splashscreen_image_url = results[0].image_url;
            resolve("success");
          }
        });
      }));

      Promise.all(promises).then(() => {

        faulty_selection.forEach(item => {
          var index = product_info.findIndex(x => x.motor_number == item.motor_number);
          if (index > -1) {
            product_info[index].status = "Stop Sales";
          }
        });
        product_info.forEach(item => {
          if (item.status == null) {
            item.status = "Normal";
          }
        });
        connection.end();
        res.send({
          status: 'OK',
          machine_id: machine_id,
          mode: mode,
          tray_slot_info: tray_slot_info,
          payment_selection: payment_selection,
          product_info: product_info,
          sleep_ads_url: sleep_ads_url,
          banner_ads_url: banner_ads_url,
          promotion_image_url: promotion_image_url,
          splashscreen_image_url: splashscreen_image_url,
        });
      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  });
});

app.post("/resetMachine", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_row_and_column";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors);
          } else {
            resolve('success');
          }
        });
      }));

      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_ads_video";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors);
          } else {
            resolve('success');
          }
        });
      }));
      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_motor_diagnose";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors);
          } else {
            resolve('success');
          }
        });
      }));
      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_product";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors);
          } else {
            resolve('success');
          }
        });
      }));
      promises.push(new Promise((resolve, reject) => {
        var query = "DROP TABLE db_payment_selection";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors);
          } else {
            var query = "CREATE TABLE db_payment_selection (id INT AUTO_INCREMENT PRIMARY KEY, machine_id VARCHAR(255), created_date DATETIME, password VARCHAR(20))";
            connection.query(query, (errors1, results1, fields1) => {
              if (errors1) {
                reject(errors)
              } else {
                resolve('success');
              }
            })
          }
        });
      }));

      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_setting";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors);
          } else {
            var query = "UPDATE db_setting SET ? WHERE machine_id = ?";
            var values = [{ is_setting_changed: null, mode: "Online", password: "abcd1234", is_pwp_enabled: false, }, results[0].machine_id];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                reject(errors);
              } else {
                resolve('success');
              }
            });

          }
        });
      }))

      Promise.all(promises).then(() => {
        connection.end();
        res.send({
          status: 'OK'
        });

      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: error
        });
      });
    }
  });
});

app.post("/resetMachine_v2", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];

      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_ads_video";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors);
          } else {
            resolve('success');
          }
        });
      }));
      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_motor_diagnose";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors);
          } else {
            resolve('success');
          }
        });
      }));
      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_product";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors);
          } else {
            resolve('success');
          }
        });
      }));

      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_select_payment";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors);
          } else {
            resolve('success');
          }
        });
      }));

      promises.push(new Promise((resolve, reject) => {
        var query = "SELECT * FROM db_setting";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject(errors);
          } else {
            var query = "UPDATE db_setting SET ? WHERE machine_id = ?";
            var values = [{ is_setting_changed: null, password: "abcd1234", admin_pw: "Nuvending888" }, results[0].machine_id];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                reject(errors);
              } else {
                resolve('success');
              }
            });

          }
        });
      }))

      Promise.all(promises).then(() => {
        connection.end();
        res.send({
          status: 'OK'
        });

      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: error
        });
      });
    }
  });
});

app.post("/checkIfRowExist_in_db", (req, res) => {
  const row_number = req.body.row_number;
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_row_and_column WHERE tray_number = ?";
      var values = [row_number];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          if (results.length != 0) {
            connection.end();
            res.send({
              status: 'OK',
              slot_number: String(results[0].slot_number),
            })
          } else {
            connection.end();
            res.send({
              status: 'error',
            })
          }

        }
      });
    }
  })
});

app.post("/checkIfMotorExist_in_db", (req, res) => {
  const motor_label = req.body.motor_label;
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_product WHERE motor_label = ?";
      var values = [motor_label];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          if (results.length != 0) {
            connection.end();
            res.send({
              status: 'OK',
              result: String(results[0].motor_number),
            })
          } else {
            connection.end();
            res.send({
              status: 'OK',
              result: "error",
            })
          }

        }
      });
    }
  })
});

app.post('/getSplashScreenImage', (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_splash_screen_image";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          var imageUrl = "";
          if (results.length > 0) {
            imageUrl = results[0].image_url;
          }
          res.send({
            status: 'OK',
            result: imageUrl
          });
        }
      });
    }
  });
});

app.post("/checkAuthentication", (req, res) => {
  const password = req.body.password;
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          if (results.length != 0) {
            if (String(password) == results[0].password) {
              connection.end();
              res.send({
                status: 'OK',
              })
            } else {
              connection.end();
              res.send({
                status: 'Wrong Password',
              })
            }
          } else {
            connection.end();
            res.send({
              status: 'OK',
              result: "error",
            })
          }
        }
      });
    }
  })
})

app.post("/checkSpecialAuth", (req, res) => {
  const password = req.body.password;
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          if (results.length != 0) {
            if (String(password) == results[0].admin_pw) {
              connection.end();
              res.send({
                status: 'OK',
              })
            } else {
              connection.end();
              res.send({
                status: 'Wrong Password',
              })
            }
          } else {
            connection.end();
            res.send({
              status: 'OK',
              result: "error",
            })
          }
        }
      });
    }
  })
})

app.post('/uploadNewPassword', (req, res) => {

  const password = req.body.password;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          var query = "UPDATE db_setting SET ? WHERE machine_id = ?";
          var values = [{ password: password }, results[0].machine_id];
          connection.query(query, values, (errors, results, fields) => {
            if (errors) {
              console.log(errors);
              connection.end();
              res.send({
                status: 'error'
              });
            } else {

              connection.end();
              res.send({
                status: 'OK',
              })
            }
          })
        }
      });
    }
  });
})

app.post('/uploadGKashInfo', (req, res) => {

  const username = req.body.username;
  const password = req.body.password;
  console.log("username", username, "pw", password);

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_setting";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          var query = "UPDATE db_setting SET ? WHERE machine_id = ?";
          var values = [{ gkash_username: username, gkash_pw: password }, results[0].machine_id];
          connection.query(query, values, (errors, results, fields) => {
            if (errors) {
              console.log(errors);
              connection.end();
              res.send({
                status: 'error'
              });
            } else {

              connection.end();
              res.send({
                status: 'OK',
              })
            }
          })
        }
      });
    }
  });
})

app.post('/clearMotorFault', (req, res) => {
  const type = req.body.type; // quarter or jam

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "";
      if (type == "quarter") {
        query = "DELETE FROM db_motor_diagnose WHERE quarter_jammed = ?";
      } else {
        query = "DELETE FROM db_motor_diagnose WHERE motor_jammed = ?";
      }
      var values = [1];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
          });
        }
      });
    }
  });
});

app.post('/queryMotorFaulty', (req, res) => {
  const type = req.body.type; // quarter or jam
  var motor_list = [];

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "";
      if (type == "quarter") {
        query = "SELECT * FROM db_motor_diagnose WHERE quarter_jammed = ?";
      } else {
        query = "SELECT * FROM db_motor_diagnose WHERE motor_jammed = ?";
      }
      var values = [1];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          results.forEach((item, index) => {
            motor_list[index] = item.motor_number;
          })
          connection.end();
          res.send({
            status: 'OK',
            result: results,
            motor_list: motor_list
          });
        }
      });
    }
  });
});

//TODO: have to send to walter before flush
app.post("/flushSensordata", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "DELETE FROM db_sensor_data";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(errors);
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK'
          });
        }
      })
    }
  })
})

app.post("/uploadTransactionFlow", (req, res) => {
  const transaction = req.body.transaction;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {

      var query = "SELECT * FROM db_payment_template";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        } else {
          results.forEach((item, index) => {
            if (item.payment_method == transaction.payment_method) {
              transaction.payment_id = item.payment_id;
            }
          })
          var query = "INSERT INTO db_transaction_flow (transaction_flow,motor_label,quantity,payment_method,drop_success,order_number,record_time) VALUES (?,?,?,?,?,?,?)";
          var values = [transaction.transaction_flow, transaction.motor_label, transaction.quantity, transaction.payment_id, transaction.drop_success, transaction.order_number, new Date()];
          connection.query(query, values, (errors, results, fields) => {
            if (errors) {
              connection.end();
              console.log(errors);
              res.send({
                status: 'error'
              });
            } else {
              connection.end();
              res.send({
                status: 'OK'
              });
            }
          });
        }
      })
    }
  })
})

app.post("/uploadTransactionFlow_v2", (req, res) => {
  const transaction = req.body.transaction;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {

      var query = "SELECT * FROM db_select_payment";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        } else {
          results.forEach((item, index) => {
            if (item.name == transaction.payment_method) {
              transaction.payment_id = item.id;
            }
          })
          var query = "INSERT INTO db_transaction_flow (transaction_flow,motor_label,quantity,payment_method,drop_success,order_number,record_time) VALUES (?,?,?,?,?,?,?)";
          var values = [transaction.transaction_flow, transaction.motor_label, transaction.quantity, transaction.payment_id, transaction.drop_success, transaction.order_number, new Date()];
          connection.query(query, values, (errors, results, fields) => {
            if (errors) {
              connection.end();
              console.log(errors);
              res.send({
                status: 'error'
              });
            } else {
              connection.end();
              res.send({
                status: 'OK'
              });
            }
          });
        }
      })
    }
  })
})

//TODO: have to send to walter before flush
app.post("/flushTransactionData", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "DELETE FROM db_transaction_flow";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          connection.end();
          console.log(errors);
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK'
          });
        }
      })
    }
  })
});

app.post("/getAllSalesTransaction", (req, res) => {
  const view_as = req.body.view_as;
  const hMonth = req.body.selected_month;
  const hYear = req.body.selected_year;

  var selected_start_for_month = new Date(hYear + "-" + (hMonth) + "-1");
  var selected_end_for_month = new Date(hYear + "-" + (hMonth) + "-1");
  selected_end_for_month.setMonth(selected_end_for_month.getMonth() + 1);

  selected_start_for_month.setHours(0);
  selected_start_for_month.setMinutes(0);
  selected_start_for_month.setSeconds(0);
  selected_start_for_month.setMilliseconds(0);

  selected_end_for_month.setHours(23);
  selected_end_for_month.setMinutes(59);
  selected_end_for_month.setSeconds(59);
  selected_end_for_month.setMilliseconds(999);

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      if (view_as == "All") {
        var query = "SELECT * FROM db_transaction_flow";
        var values = [];
      } else if (view_as == "Month") {
        var query = "SELECT * FROM db_transaction_flow WHERE record_time >= ? AND record_time <= ?";
        var values = [selected_start_for_month, selected_end_for_month];
      }

      connection.query(query, values, (errors, results, fields) => {
        console.log("results", results)
        if (errors) {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        } else {
          results.forEach((resultItem, resultIndex) => {
            promises.push(new Promise((resolve, reject) => {
              var query = "SELECT * FROM db_product WHERE motor_label = ?";
              var values = [resultItem.motor_label];
              connection.query(query, values, (errors, results, fields) => {
                if (errors) {
                  reject('error');
                } else {
                  resultItem.unit_price = results[0].price;
                  resultItem.total_price = parseFloat(results[0].price.toFixed(2) * Number(resultItem.quantity)).toFixed(2);
                  resolve('success');
                }
              });
            }));
            promises.push(new Promise((resolve, reject) => {
              var query = "SELECT * FROM db_payment_template WHERE payment_id = ?";
              var values = [resultItem.payment_method];
              connection.query(query, values, (errors, results, fields) => {
                if (errors) {
                  reject('error');
                } else {
                  resultItem.payment_name = results[0].payment_method;

                  resolve('success');
                }
              });
            }));

          })
          Promise.all(promises).then(() => {
            connection.end();
            res.send({
              status: 'OK',
              result: results,
            });

          }).catch(error => {
            connection.end();
            console.log(error);
            res.send({
              status: 'error1'
            });
          });

        }
      });
    }
  })
});

app.post("/getAllSalesTransaction_v2", (req, res) => {
  const view_as = req.body.view_as;
  const hMonth = req.body.selected_month;
  const hYear = req.body.selected_year;

  var selected_start_for_month = new Date(hYear + "-" + (hMonth) + "-1");
  var selected_end_for_month = new Date(hYear + "-" + (hMonth) + "-1");
  selected_end_for_month.setMonth(selected_end_for_month.getMonth() + 1);

  selected_start_for_month.setHours(0);
  selected_start_for_month.setMinutes(0);
  selected_start_for_month.setSeconds(0);
  selected_start_for_month.setMilliseconds(0);

  selected_end_for_month.setHours(23);
  selected_end_for_month.setMinutes(59);
  selected_end_for_month.setSeconds(59);
  selected_end_for_month.setMilliseconds(999);

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      if (view_as == "All") {
        var query = "SELECT * FROM db_transaction_flow";
        var values = [];
      } else if (view_as == "Month") {
        var query = "SELECT * FROM db_transaction_flow WHERE record_time >= ? AND record_time <= ?";
        var values = [selected_start_for_month, selected_end_for_month];
      }

      connection.query(query, values, (errors, results, fields) => {
        console.log("results", results)
        if (errors) {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        } else {
          results.forEach((resultItem, resultIndex) => {
            promises.push(new Promise((resolve, reject) => {
              var query = "SELECT * FROM db_product WHERE motor_label = ?";
              var values = [resultItem.motor_label];
              connection.query(query, values, (errors, results, fields) => {
                if (errors) {
                  reject('error');
                } else {
                  resultItem.unit_price = results[0].price;
                  resultItem.total_price = parseFloat(results[0].price.toFixed(2) * Number(resultItem.quantity)).toFixed(2);
                  resolve('success');
                }
              });
            }));
            promises.push(new Promise((resolve, reject) => {
              var query = "SELECT * FROM db_select_payment WHERE payment_id = ?";
              var values = [resultItem.payment_method];
              connection.query(query, values, (errors, results, fields) => {
                if (errors) {
                  reject('error');
                } else {
                  resultItem.payment_name = results[0].name;
                  resultItem.image_url = results[0].image;

                  resolve('success');
                }
              });
            }));

          })
          Promise.all(promises).then(() => {
            connection.end();
            res.send({
              status: 'OK',
              result: results,
            });

          }).catch(error => {
            connection.end();
            console.log(error);
            res.send({
              status: 'error1'
            });
          });

        }
      });
    }
  })
});

app.post('/insertSalesRecord', (req, res) => {
  const transaction_serial = req.body.transaction_serial;
  const slot_number = req.body.slot_number; // A1, A2...
  const price = req.body.price;
  const quantity = req.body.quantity;
  const drop_sensor_status = req.body.drop_sensor_status;
  const payment_method = req.body.payment_method;
  const self_defined_payment_method = req.body.self_defined_payment_method;
  const order_number = req.body.order_number;
  const machine_id = req.body.machine_id;
  const report_status = req.body.report_status;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_product WHERE motor_label = ?";
      var values = [slot_number];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          if (results.length > 0) {
            var product_name = results[0].product_name;
            var image_url = results[0].product_image_url;
            var query = "INSERT INTO db_sales_record (id,transaction_serial,slot_number,price,quantity,product_name,drop_sensor_status,payment_method,self_defined_payment_method,order_number,machine_id,product_url,report_status,date_time) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            var values = [null, transaction_serial, slot_number, price, quantity, product_name, drop_sensor_status, payment_method, self_defined_payment_method, order_number, machine_id, image_url, report_status, new Date()];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                connection.end();
                res.send({
                  status: 'error'
                });
              } else {
                connection.end();
                res.send({
                  status: 'OK'
                });
              }
            });
          } else {
            connection.end();
            res.send({
              status: 'error'
            });
          }
        }
      });
    }
  });
});

app.post('/getAllOfflineSalesRecord', (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_sales_record WHERE report_status = ?";
      var values = ["offline"];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
            result: results
          });
        }
      });
    }
  });
});

app.post('/updateSalesRecordStatus', (req, res) => {
  const order_number = req.body.order_number;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "UPDATE db_sales_record SET ? WHERE order_number = ?";
      var values = [{ report_status: "online" }, order_number];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK'
          });
        }
      });
    }
  });
});

app.post('/getAllSalesRecord', (req, res) => {
  const hMonth = req.body.selected_month;
  const hYear = req.body.selected_year;

  var selected_start_for_month = new Date(hYear + "-" + (hMonth) + "-1");
  var selected_end_for_month = new Date(hYear + "-" + (hMonth) + "-1");
  selected_end_for_month.setMonth(selected_end_for_month.getMonth() + 1);

  selected_start_for_month.setHours(0);
  selected_start_for_month.setMinutes(0);
  selected_start_for_month.setSeconds(0);
  selected_start_for_month.setMilliseconds(0);

  selected_end_for_month.setHours(23);
  selected_end_for_month.setMinutes(59);
  selected_end_for_month.setSeconds(59);
  selected_end_for_month.setMilliseconds(999);

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_sales_record WHERE date_time >= ? AND date_time <= ?";
      var values = [selected_start_for_month, selected_end_for_month];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
            result: results
          });
        }
      });
    }
  });
});

app.post('/getMaxMotorLabel', (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT MAX(id) FROM db_product";

      connection.query(query, (errors, idResult, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          if (idResult.length > 0) {
            var query = "SELECT * FROM db_product WHERE id = ?";
            var values = [Object.values((Object.values(idResult)[0]))];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                connection.end();
                res.send({
                  status: 'error'
                });
              } else {
                connection.end();
                res.send({
                  status: 'OK',
                  result: results[0].motor_label,
                  id: Object.values((Object.values(idResult)[0]))
                });
              }
            })

          } else {
            connection.end();
            res.send({
              status: 'error',
              result: 'empty db'
            });
          }
        }
      });
    }
  });
});

app.post('/getLocalPaymentMethod', (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_select_payment WHERE status = ?";
      var values = [1];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          results.forEach(item => {
            item.imageUrl = item.image;
            item.isSelected = true;
          });
          res.send({
            status: 'OK',
            result: results,
          });
        }
      });
    }
  });
});

app.post('/checkRFIDValidity', (req, res) => {
  const rfid_code = req.body.rfid_code;

  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_rfid_card WHERE rfid_code = ? AND status = ?";
      var values = [rfid_code, "active"];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          if (results.length > 0) {
            res.send({
              status: 'OK',
              discount_rate: results[0].discount_rate_percent,
            });
          } else {
            res.send({
              status: 'invalid',
            });
          }
        }
      });
    }
  });
});
app.post('/getRFIDInfo', (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_rfid_card";
      connection.query(query,(errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          if (results.length > 0) {
            res.send({
              status: 'OK',
              result: results,
            });
          } else {
            res.send({
              status: 'error',
            });
          }
        }
      });
    }
  });
});

app.post('/addRFIDInfo', (req, res) => {
  const rfid_code = req.body.rfid_code;
  const discount_rate_percent = req.body.discount_rate_percent;
  const status = req.body.status;
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "INSERT INTO db_rfid_card (rfid_code,discount_rate_percent,status) VALUES (?,?,?)";
      var values = [rfid_code, discount_rate_percent, status];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error',
            error:errors
          });
        } else {
          connection.end();
            res.send({
              status: 'OK',
            });
        }
      });
    }
  });
});

app.post('/removeRFIDInfo', (req, res) => {
  const rfid_code = req.body.rfid_code;
  const discount_rate_percent = req.body.discount_rate_percent;
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "DELETE FROM db_rfid_card WHERE rfid_code = ?";
            var values = [rfid_code]
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
            res.send({
              status: 'OK',
            });

        }
      });
    }
  });
});

app.post('/updateRFIDInfo', (req, res) => {
  const rfid_code = req.body.rfid_code;
  const discount_rate_percent = req.body.discount_rate_percent;
  const status = req.body.status;
  var connection = mysql.createConnection(dbConnectionParam);

  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "UPDATE db_rfid_card SET ? WHERE rfid_code = ?";
      var values = [{ discount_rate_percent: discount_rate_percent, status: status },rfid_code];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          connection.end();
          res.send({
            status: 'error',
            error:errors
          });
        } else {
          connection.end();
            res.send({
              status: 'OK',
            })
        }
      });
    }
  });
});

app.post('/getGhlPayment', (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);
  const id = req.body.id;
  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_ghl_payment WHERE id = ?";
      var values = [id];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
            result: results,
          })
        }
      });
    }
  });
});

app.post("/insertGhlPayment", (req, res) => {
  const payment_method = req.body.payment_method;
  const amount = parseFloat(req.body.amount) / 100;
  var connection = mysql.createConnection(dbConnectionParam);
  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "INSERT INTO db_ghl_payment (payment_method,time_created,status,amount) VALUES (?,?,?,?)";
      var values = [payment_method, new Date(), "pending", amount];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
            result: results.insertId,
          })
        }
      });
    }
  })
});

app.post("/updateGhlPayment", (req, res) => {
  const id = req.body.id;
  const transaction_trace = req.body.transaction_trace;
  const payment_method = req.body.payment_method;
  const batch_number = req.body.batch_number;
  const host_id = req.body.host_id;
  const status = req.body.status;
  console.log(id, transaction_trace, payment_method, batch_number, host_id, status)
  var connection = mysql.createConnection(dbConnectionParam);
  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "UPDATE db_ghl_payment SET ? WHERE id = ?";
      var values = [{ payment_method: payment_method, transaction_trace: transaction_trace, batch_number: batch_number, host_id: host_id, time_response: new Date(), status: status }, id];
      connection.query(query, values, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: errors
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',

          })
        }
      });
    }
  })
});
app.post("/updateUsbConfiguration", (req, res) => {
  const usb_port_list = req.body.usb_port_list;
  console.log("updateUsbConfiguration");

  console.log(usb_port_list);
  console.log(usb_port_list.length);
  const device = req.body.device;
  const port = req.body.port;

  var connection = mysql.createConnection(dbConnectionParam);
  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var promises = [];
      var promises1 = [];
      promises.push(new Promise((resolve, reject) => {
        var query = "DELETE FROM db_usb_configuration";
        connection.query(query, (errors, results, fields) => {
          if (errors) {
            reject('error');
          } else {
            resolve('success');
          }
        });
      }));
      Promise.all(promises).then(() => {

        promises1.push(new Promise((resolve1, reject1) => {
          usb_port_list.forEach((item, index) => {
            var query = "INSERT INTO db_usb_configuration (device,port) VALUES (?,?)";
            var values = [item.device, item.port];
            connection.query(query, values, (errors, results, fields) => {
              if (errors) {
                reject1('error');
              } else {
                resolve1('success');
              }
            });
          })
        }));
        Promise.all(promises1).then(() => {
          connection.end();
          res.send({
            status: 'OK',
          });
        }).catch(error => {
          connection.end();
          console.log(error);
          res.send({
            status: 'error'
          });
        });

      }).catch(error => {
        connection.end();
        console.log(error);
        res.send({
          status: 'error'
        });
      });
    }
  })
});

app.post("/getLocalUsbConfiguration", (req, res) => {

  var connection = mysql.createConnection(dbConnectionParam);
  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_usb_configuration";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: errors
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
            results: results

          })
        }
      });
    }
  })
});


app.post("/getSerialPort", (req, res) => {
  var listUsb = [];
  var noConnection = false;
  fs.readdir('/dev/serial/by-id', (err, files) => {
    if (err) {
      noConnection = true;
      console.log("no serial connection");
    } else {
      console.log("got serial connection");
      if (files != null) {
        files.forEach(file => {
          listUsb.push('/dev/serial/by-id/'+ file)
        });
      } else {
        noConnection = true;
        console.log("no serial connection");
      }

    }

    fs.readdir('/dev/input/by-id', (err, files) => {
      if (err) {
        console.log("no input connection");
        if (noConnection) {
          res.send({
            status: "error",
          });
        } else {
          res.send({
            status: "OK",
            result: listUsb
          });
        }
      } else {
        console.log("got input connection");
        if (files != null) {
          files.forEach(file => {
            listUsb.push('/dev/input/by-id/'+ file)
          });
        } else {
          console.log("no serial connection");
        }
        res.send({
          status: "OK",
          result: listUsb
        });
      }
    });
  });
});


app.post("/getUsbPort", (req, res) => {
  var connection = mysql.createConnection(dbConnectionParam);
  connection.connect((error) => {
    if (error) {
      console.log("error connecting: " + error.stack);
      res.send({
        status: "error",
      });
    } else {
      var query = "SELECT * FROM db_usb_configuration";
      connection.query(query, (errors, results, fields) => {
        if (errors) {
          console.log(errors);
          connection.end();
          res.send({
            status: 'error'
          });
        } else {
          connection.end();
          res.send({
            status: 'OK',
            result: results,
          })
        }
      });
    }
  });
});
app.listen(port, () => console.log(`Nubox API listening on port ${port}!`));
