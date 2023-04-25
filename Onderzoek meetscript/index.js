const mysql = require('mysql');
const query = `UPDATE \`product_sold\` SET \`id\`=5, \`price_total\`=XXX, \`quantity\`=1, \`pos\`='service balie', \`store\`='plus', \`area\`='Groningen', \`area_lon\`=2.5235626, \`area_lat\`=5.21623, \`employee_firstname\`='Jeroen', \`employee_surname\`='de Brug', \`employee_function\`='clerk', \`customer_firstname\`='Anja', \`customer_surname\`='de Put', \`customer_iban\`=NULL, \`customer_postalcode\`='3261AB', \`product_name\`='bloemkool', \`product_has_upc\`=0, \`product_upc\`=NULL, \`product_category\`='vegables' WHERE \`id\`=5;`
const schema = "flatfile";
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
    //await connection.query(`INSERT INTO \`f_product_sold\` (\`id\`, \`price_total\`, \`quantity\`, \`SKU_id\`, \`POS_id\`, \`Area_id\`, \`customer_id\`, \`Employee_id\`) VALUES (28, 25, 6, 6, 5, 2, 4, 4);`)
    //await connection.query(`DELETE FROM \`f_product_sold\` WHERE \`id\`=28;`)
   //await connection.query(`INSERT INTO \`f_product_sold\` (\`id\`, \`price_total\`, \`quantity\`, \`d_SKU_id\`, \`d_customer_id\`, \`d_employee_id\`, \`d_pos_id\`) VALUES (10, 25, 10, 1, 3, 3, 4);`)
}