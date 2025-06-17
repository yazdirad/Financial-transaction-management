const db = require('./../../config/db');
const categoriesType = require('./../../models/enums/categoriesType');

class categoriesController {
    showList = async (req, res) => {
        try {
            const [rows] = await db.query('SELECT * FROM categories');
            res.render('categories/list', { categories: rows, categoriesType: categoriesType })
        } catch (error) {
            console.error('Error fetching users:', error);
            res.status(500).send('Server Error');
        }
    }

    addCategory = async (req, res) => {
        const { title } = req.body;
        const { categoryType } = req.body;

        if (!title) {
            return res.status(400).json({
                success: false,
                message: "عنوان الزامی است!"
            });
        }

        if (!categoryType) {
            return res.status(400).json({
                success: false,
                message: "انتخاب نوع حساب الزامی است!"
            });
        }

        if (!(Object.values(categoriesType).find(item=> item.id == categoryType))) {
            return res.status(400).json({
                success: false,
                message: "نوع حساب معتبر نیست!"
            });
        }

        try {
            const [result] = await db.query("INSERT INTO categories (title,categoryType) VALUES (?,?)", [title, categoryType]);

            if (result.insertId) {
                res.json({ success: true });
            } else {
                res.json({ success: false, message: "افزودن سرفصل ناموفق بود" });
            }
        } catch (error) {
            console.error("Error adding category:", error);
            res.status(500).json({ success: false, message: "خطای سرور" });
        }
    };

    updateCategory = async (req, res) => {
        try {
            const { id } = req.params; // گرفتن id از پارامتر URL
            const { title } = req.body;
            const { categoryType } = req.body;

            const [result] = await db.query(
                "UPDATE categories SET title = ?, categoryType = ? WHERE id = ?",
                [title, categoryType, id]
            );

            if (result.affectedRows > 0) {
                res.json({ success: true });
            } else {
                res.json({ success: false, message: "سرفصل یافت نشد" });
            }
        } catch (error) {
            console.error("Error updating category:", error);
            res.status(500).json({ success: false, message: "خطای سرور" });
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
            res.status(500).json({ success: false, message: "خطای سرور" });
        }
    };
}

module.exports = new categoriesController();