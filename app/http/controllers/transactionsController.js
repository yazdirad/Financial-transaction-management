const db = require('../../config/db');

class transactionsController {
    showList = async (req, res) => {
        const page = parseInt(req.query.page) || 1;
        const size = 10;
        const skip = (page - 1) * size;
        try {
            const [rows] = await db.query(
                // "SELECT * FROM transactions ORDER BY trans_date DESC LIMIT ?, ?",
                "SELECT " +
                "    transactions.id " +
                "    ,transactions.unit_id " +
                "    ,units.unit_number " +
                "    ,units.floor AS unit_floor " +
                "    ,transactions.category_id " +
                "    ,categories.title AS category_title " +
                "    ,transactions.amount " +
                "    ,transactions.type " +
                "    ,transactions.trans_date " +
                "    ,transactions.is_cash " +
                "    ,transactions.account_id " +
                "    ,transactions.for_resident " +
                "    ,transactions.description " +
                "FROM transactions " +
                "LEFT JOIN categories ON categories.id = transactions.category_id " +
                "LEFT JOIN units ON units.id = transactions.unit_id " +
                "ORDER BY trans_date DESC LIMIT ?, ? ",
                [skip, size]
            );
            // rows.forEach(item => {
            //     item.trans_date_fa = moment(item.trans_date).format('jYYYY/jMM/jDD')
            // });
            const [totalCount] = await db.query('SELECT COUNT(id) AS totalCount FROM transactions');
            res.render('transactions/list', { transactions: rows, totalCount: totalCount[0].totalCount, currentPage: page })
        } catch (error) {
            console.error('Error fetching users:', error);
            res.status(500).send('Server Error');
        }
    }

    add = async (req, res) => {
        const { title } = req.body;
        const { account_number } = req.body;
        const { sheba_number } = req.body;
        const { cart_number } = req.body;
        const { owners } = req.body;
        const { is_active } = req.body;

        if (!title || !owners || !is_active) {
            return res.status(400).json({
                success: false,
                message: "تمامی فیلدها الزامی است!"
            });
        }

        try {
            const [result] = await db.query(
                "INSERT INTO accounts (title, account_number, sheba_number, cart_number, owners, is_active) VALUES (?,?,?,?,?,?)",
                [title, account_number, sheba_number, cart_number, owners, is_active]
            );

            if (result.insertId) {
                res.json({ success: true });
            } else {
                res.json({ success: false, message: "افزودن حساب ناموفق بود" });
            }
        } catch (error) {
            console.error("Error adding account:", error);
            res.status(500).json({ success: false, message: "خطای سرور" });
        }
    };

    update = async (req, res) => {
        try {
            const { id } = req.params; // گرفتن id از پارامتر URL
            const { title } = req.body;
            const { account_number } = req.body;
            const { sheba_number } = req.body;
            const { cart_number } = req.body;
            const { owners } = req.body;
            const { is_active } = req.body;

            if (!title || !owners || !is_active) {
                return res.status(400).json({
                    success: false,
                    message: "تمامی فیلدها الزامی است!"
                });
            }

            const [result] = await db.query(
                "UPDATE accounts SET title = ?, account_number = ?, sheba_number = ?, cart_number = ?, owners = ?, is_active = ? WHERE id = ?",
                [title, account_number, sheba_number, cart_number, owners, is_active, id]
            );

            if (result.affectedRows > 0) {
                res.json({ success: true });
            } else {
                res.json({ success: false, message: "حساب یافت نشد" });
            }
        } catch (error) {
            console.error("Error updating unit:", error);
            res.status(500).json({ success: false, message: "خطای سرور" });
        }
    };

    delete = async (req, res) => {
        try {
            const { id } = req.params;
            const [result] = await db.query("DELETE FROM accounts WHERE id = ?", [id]);

            if (result.affectedRows > 0) {
                res.json({ success: true });
            } else {
                res.json({ success: false, message: "آیتم یافت نشد" });
            }
        } catch (error) {
            console.error("Error deleting category:", error);
            res.status(500).json({ success: false, message: "خطای سرور" });
        }
    };
}

module.exports = new transactionsController();