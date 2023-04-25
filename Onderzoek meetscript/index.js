const mysql = require('mysql');
const query = `INSERT INTO \`d_area\` (\`id\`, \`name\`, \`lon\`, \`lat\`) VALUES (3, 'Amsterdam', 4.8951679, 52.3702157);
INSERT INTO \`d_store\` (\`id\`, \`name\`, \`area_id\`) VALUES (5, 'Appie to Go', 3);
INSERT INTO \`d_pos\` (\`id\`, \`name\`, \`store_id\`) VALUES (8, 'zelfscan1', 5);

INSERT INTO \`d_catagory\` (\`id\`, \`catagory\`) VALUES (5, 'cheese');
INSERT INTO \`d_sku\` (\`id\`, \`product_name\`, \`hasUPC\`, \`UPC\`, \`catagory_id\`) VALUES (7, 'Old Amsterdam kaas', 0, NULL, 5);

INSERT INTO \`d_postalcode\` (\`id\`, \`postalcode\`) VALUES (3, '5647HS');
INSERT INTO \`d_customer\` (\`id\`, \`firstname\`, \`surname\`, \`IBAN\`, \`postalcode_id\`) VALUES (4, 'Anja', 'van der Broek', NULL, 3);

INSERT INTO \`d_function\` (\`id\`, \`function\`) VALUES (4, 'department manager');
INSERT INTO \`d_employee\` (\`id\`, \`firstname\`, \`surname\`, \`function_id\`) VALUES (5, 'Sophie', 'de Vries', 4);

INSERT INTO \`f_product_sold\` (\`id\`, \`price_total\`, \`quantity\`, \`SKU_id\`, \`customer_id\`, \`Employee_id\`, \`POS_id\`) VALUES (8, 25, 10, 7, 4, 5, 8);`
const schema = "galaxy";
const query_name = "add_all_new";
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
    await connection.query(`DELETE FROM \`f_product_sold\` WHERE \`id\`=8;
    DELETE FROM \`d_employee\` WHERE \`id\`=5;
    DELETE FROM \`d_function\` WHERE \`id\`=4;
    DELETE FROM \`d_customer\` WHERE \`id\`=4;
    DELETE FROM \`d_postalcode\` WHERE \`id\`=3;
    DELETE FROM \`d_sku\` WHERE \`id\`=7;
    DELETE FROM \`d_catagory\` WHERE \`id\`=5;
    DELETE FROM \`d_pos\` WHERE \`id\`=8;
    DELETE FROM \`d_store\` WHERE \`id\`=5;
    DELETE FROM \`d_area\` WHERE \`id\`=3;
    `)
}