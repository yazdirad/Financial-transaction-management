const db = require('./../../config/db');

class unitsController {
    showList = async (req, res) => {
        const skip = 0;
        const size = 6;
        try {
            const [rows] = await db.query(
                "SELECT * FROM units ORDER BY unit_number ASC LIMIT ?, ?",
                [skip, size]
            );
            const [totalCount] = await db.query('SELECT COUNT(id) AS totalCount FROM units');
            res.render('units/list', { units: rows, totalCount: totalCount[0].totalCount })
        } catch (error) {
            console.error('Error fetching users:', error);
            res.status(500).send('Server Error');
        }
    }

    getList = async (req, res) => {
        const page = req.body.page;
        const size = 6;
        const skip = (page - 1) * size;
        try {
            const [rows] = await db.query(
                "SELECT * FROM units ORDER BY unit_number ASC LIMIT ?, ?",
                [skip, size]
            );
            const [totalCount] = await db.query('SELECT COUNT(id) AS totalCount FROM units');
            res.json({ units: rows, totalCount: totalCount[0].totalCount })
        } catch (error) {
            console.error('Error fetching users:', error);
            res.status(500).send('Server Error');
        }
    }

    addUnit = async (req, res) => {
        const { unit_number } = req.body;
        const { floor } = req.body;
        const { meterage } = req.body;
        const { has_parking } = req.body;
        const { has_warehouse } = req.body;

        if (!unit_number || !floor || !meterage || !has_parking || !has_warehouse) {
            return res.status(400).json({
                success: false,
                message: "تمامی فیلدها الزامی است!"
            });
        }

        try {
            const [result] = await db.query(
                "INSERT INTO units (unit_number, floor, meterage, has_parking, has_warehouse) VALUES (?,?,?,?,?)",
                [unit_number, floor, meterage, has_parking, has_warehouse]
            );

            if (result.insertId) {
                res.json({ success: true });
            } else {
                res.json({ success: false, message: "افزودن واحد ناموفق بود" });
            }
        } catch (error) {
            console.error("Error adding unit:", error);
            res.status(500).json({ success: false, message: "خطای سرور" });
        }
    };

    updateUnit = async (req, res) => {
        try {
            const { id } = req.params; // گرفتن id از پارامتر URL
            const { unit_number } = req.body;
            const { floor } = req.body;
            const { meterage } = req.body;
            const { has_parking } = req.body;
            const { has_warehouse } = req.body;

            const [result] = await db.query(
                "UPDATE units SET unit_number = ?, floor = ?, meterage = ?, has_parking = ?, has_warehouse = ? WHERE id = ?",
                [unit_number, floor, meterage, has_parking, has_warehouse, id]
            );

            if (result.affectedRows > 0) {
                res.json({ success: true });
            } else {
                res.json({ success: false, message: "واحد یافت نشد" });
            }
        } catch (error) {
            console.error("Error updating unit:", error);
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

module.exports = new unitsController();