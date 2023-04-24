const mysql = require('mysql');
const query = `INSERT INTO \`d_area\` (\`id\`, \`name\`, \`lon\`, \`lat\`) VALUES (3, 'Amsterdam', 4.8951679, 52.3702157);
INSERT INTO \`d_customer\` (\`id\`, \`firstname\`, \`surname\`, \`IBAN\`, \`postalcode\`) VALUES (5, 'Anja', 'van der Broek', NULL, '2675BL');
INSERT INTO \`d_employee\` (\`id\`, \`firstname\`, \`surname\`, \`function\`) VALUES (5, 'Sophie', 'de Vries', 'cashier');
INSERT INTO \`d_pos\` (\`id\`, \`store\`, \`location\`, \`name\`) VALUES (6, 'Appie to go', 'Amsterdam', 'Zelfscan1');
INSERT INTO \`d_sku\` (\`id\`, \`product_name\`, \`hasUPC\`, \`UPC\`, \`category\`) VALUES (7, 'Old Amsterdam kaas', 0, NULL, 'cheese');
INSERT INTO \`f_product_sold\` (\`id\`, \`price_total\`, \`quantity\`, \`SKU_id\`, \`POS_id\`, \`Area_id\`, \`customer_id\`, \`Employee_id\`) VALUES (27, 25, 10, 7, 6, 3, 5, 5);`
const schema = "star";
const query_name = "all_new_data";
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
        console.log('Status flushed');
      });

      
    
    let start = Date.now();
    console.log("start time" + start)
    connection.query(query , async (error, results) => {
        if (error) throw error;
        let end = Date.now();
        const duration = end - start;
        console.log(`Query executed in ${duration} ms`);
        connection.query(`
        DELETE FROM f_product_sold WHERE id=27;
        DELETE FROM d_area WHERE id=3;
        DELETE FROM d_customer WHERE id=5;
        DELETE FROM d_pos WHERE id=6;
        DELETE FROM d_sku WHERE id=7;
        `, async (error, results) => {
            if (error) throw error;
            connectionAdmin.query(`INSERT INTO results (query_name, schema_name, duration) VALUES ('${query_name}', '${schema}', ${duration});`)
            if(i < amount_of_tests)
                await doIt(connection, connectionAdmin, i + 1);
          });
        
    });
}