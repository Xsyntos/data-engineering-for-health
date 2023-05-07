const mysql = require('mysql');
const query = `UPDATE \`S_receipt\` SET \`quantity\`=XXX, \`total_price\`=5 WHERE \`id\`=6;`
const schema = "datavault";
const query_name = "update";
const amount_of_tests = 100;

run();

async function run() {
    const connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'root',
        database: 'mydb',
        port: 23306,
        multipleStatements: true
    });
    const connectionAdmin = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'root',
        database: 'root',
        port: 33306
    });
      
      await doIt(connection, connectionAdmin, 0);
      //connection.end();

}

function doIt(connection, connectionAdmin, i) {
    connection.query('FLUSH STATUS', (error, results) => {
        if (error) throw error;
      });

    let start = Date.now();
    console.log("start time" + start)
    connection.query(query.replace("XXX", (i % 2) + 1) , async (error, results) => {
        if (error) throw error;
        let end = Date.now();
        const duration = end - start;
        console.log(`Query executed in ${duration} ms`);
        connectionAdmin.query(`INSERT INTO results (query_name, schema_name, duration) VALUES ('${query_name}', '${schema}', ${duration});`, async (error, results) => {
            console.log("inserted value")
            await unDoIt(connection).then(async () => {
                if(i < amount_of_tests)
                    await doIt(connection, connectionAdmin, i + 1);
                else
                    console.log("done")
            }) 
        })
    });
}

async function unDoIt(connection){
//    await connection.query(`
//    INSERT INTO \`L_product_sold\` (\`H_employee_id\`, \`id\`, \`H_customer_id\`, \`H_product_id\`, \`H_pos_id\`, \`H_order_details_id\`) VALUES (3, 7, 3, 3, 6, 6);
//    `)
}