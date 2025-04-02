const db = require('./../../config/db');

class categoriesController {
    showList = async (req, res) => {
        try {
            const [rows] = await db.query('SELECT * FROM categories');
            res.render('categories/list', { categories: rows })
        } catch (error) {
            console.error('Error fetching users:', error);
            res.status(500).send('Server Error');
        }
    }

    addCategory = async (req, res) => {
        try {
            const { title } = req.body;
            const [result] = await db.query("INSERT INTO categories (title) VALUES (?)", [title]);

            if (result.insertId) {
                res.json({ success: true });
            } else {
                res.json({ success: false, message: "افزودن سرفصل ناموفق بود" });
            }
        } catch (error) {
            console.error("Error adding category:", error);
            res.json({ success: false, message: "خطای سرور" });
        }
    };

    updateCategory = async (req, res) => {
        try {
            const { id } = req.params; // گرفتن id از پارامتر URL
            const { title } = req.body;

            const [result] = await db.query(
                "UPDATE categories SET title = ? WHERE id = ?",
                [title, id]
            );

            if (result.affectedRows > 0) {
                res.json({ success: true });
            } else {
                res.json({ success: false, message: "سرفصل یافت نشد" });
            }
        } catch (error) {
            console.error("Error updating category:", error);
            res.json({ success: false, message: "خطای سرور" });
        }
    };

    deleteCategory = async (req, res) => {
        try {
            const { id } = req.params;
            const [result] = await db.query("DELETE FROM categories WHERE id = ?", [id]);

            if (result.affectedRows > 0) {
                res.json({ success: true });
            } else {
                res.json({ success: false, message: "سرفصل یافت نشد" });
            }
        } catch (error) {
            console.error("Error deleting category:", error);
            res.json({ success: false, message: "خطای سرور" });
        }
    };
}

module.exports = new categoriesController();