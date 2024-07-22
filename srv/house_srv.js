const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { grocery, worker, monthlyexpenditure, utility, maintenance } = this.entities;

    
    // Grocery operations
    this.on('READ', grocery, async req => {
        return await SELECT.from(grocery).where(req.query.SELECT.where);
    });

    this.before('CREATE', 'groceries', async (req) => {
        const { monthlyexpenditure_id } = req.data;
        if (monthlyexpenditure_id) {
            const tx = cds.transaction(req);
            const monthlyExp = await tx.run(SELECT.one.from('monthlyexpenditure').where({ id: monthlyexpenditure_id }));
            if (!monthlyExp) throw new Error('Monthly expenditure with ID ${monthlyexpenditure_id} not found');
        }
    });

    this.before('CREATE', grocery, async (req) => {
        const { quantity, price } = req.data;
        if (quantity <= 0) throw new Error('Quantity must be greater than zero');
        if (price <= 0) throw new Error('Price must be greater than zero');
        });

    this.on('UPDATE', grocery, async req => {
        const groceryId = req.params[0];
        const groceryData = req.data;
        const result = await UPDATE(grocery).set(groceryData).where({ id: groceryId });
        return result;
    });

    this.on('DELETE', grocery, async req => {
        const groceryId = req.params[0];
        const result = await DELETE.from(grocery).where({ id: groceryId });
        return result;
    });


    // Worker operations
    this.on('READ', worker, async req => {
        return await SELECT.from(worker).where(req.query.SELECT.where);
    });

    this.before('CREATE', worker, async (req) => {
        const { hourlyrate, hoursworked } = req.data;
        if (hourlyrate <= 0) throw new Error('Hourly rate must be greater than zero');
        if (hoursworked < 0) throw new Error('Hours worked cannot be negative');
        req.data.paymentdue = hourlyrate * hoursworked;
    });

    this.on('calculatePayment', async (req) => {
        const { workerId } = req.data;
        const worker = await SELECT.one.from(worker).where({ id: workerId });
        if (!worker) throw new Error('Worker not found');
        return { paymentDue: worker.hourlyrate * worker.hoursworked };
    });

    this.on('UPDATE', worker, async req => {
        const workerId = req.params[0];
        const workerData = req.data;
        const result = await UPDATE(worker).set(workerData).where({ id: workerId });
        return result;
    });

    this.on('DELETE', worker, async req => {
        const workerId = req.params[0];
        const result = await DELETE.from(worker).where({ id: workerId });
        return result;
    });


    // Monthly Expenditure operations
    this.on('READ', monthlyexpenditure, async req => {
        return await SELECT.from(monthlyexpenditure).where(req.query.SELECT.where);
    });

    this.before('CREATE', monthlyexpenditure, async (req) => {
        const { month, year } = req.data;
        if (month < 1 || month > 12) throw new Error('Invalid month');
        if (year < 2000 || year > 2100) throw new Error('Invalid year');

        // Check if an entry for this month and year already exists
        const existing = await SELECT.one.from(monthlyexpenditure).where({ month, year });
        if (existing) throw new Error('An entry for this month and year already exists');
    });

    this.on('UPDATE', monthlyexpenditure, async req => {
        const expenditureId = req.params[0];
        const expenditureData = req.data;
        const result = await UPDATE(monthlyexpenditure).set(expenditureData).where({ id: expenditureId });
        return result;
    });

    this.on('DELETE', monthlyexpenditure, async req => {
        const expenditureId = req.params[0];
        const result = await DELETE.from(monthlyexpenditure).where({ id: expenditureId });
        return result;
    });

    this.after('READ', monthlyexpenditure, async (results) => {
        // Calculate total expense for each entry
        results.forEach(entry => {
            entry.totalexpense = entry.groceryexpense + entry.workerexpense + entry.utilityexpense;
        });
    });


    // Utility operations
    this.on('READ', utility, async req => {
        return await SELECT.from(utility).where(req.query.SELECT.where);
    });

    this.before('CREATE', utility, async (req) => {
        const { amount, duedate } = req.data;
        if (amount <= 0) throw new Error('Amount must be greater than zero');
        if (new Date(duedate) < new Date()) throw new Error('Due date cannot be in the past');
    });

    this.on('UPDATE', utility, async req => {
        const utilityId = req.params[0];
        const utilityData = req.data;
        const result = await UPDATE(utility).set(utilityData).where({ id: utilityId });
        return result;
    });

    this.on('DELETE', utility, async req => {
        const utilityId = req.params[0];
        const result = await DELETE.from(utility).where({ id: utilityId });
        return result;
    });


    // Maintenance operations
    this.on('READ', maintenance, async req => {
        return await SELECT.from(maintenance).where(req.query.SELECT.where);
    });

    this.before('CREATE', maintenance, async (req) => {
        const { cost, date } = req.data;
        if (cost < 0) throw new Error('Cost cannot be negative');
        if (new Date(date) < new Date()) throw new Error('Maintenance date cannot be in the past');
        req.data.status = 'pending'; // Default status
    });

    this.on('updateStatus', async (req) => {
        const { maintenanceId, newStatus } = req.data;
        if (!['pending', 'inprogress', 'completed'].includes(newStatus)) {
            throw new Error('Invalid status');
        }
        const result = await UPDATE(maintenance)
            .set({ status: newStatus })
            .where({ id: maintenanceId });
        if (result === 0) throw new Error('Maintenance task not found');
        return { message: 'Maintenance status updated' };
    });

    this.on('DELETE', maintenance, async req => {
        const maintenanceId = req.params[0];
        const result = await DELETE.from(maintenance).where({ id: maintenanceId });
        return result;
    });
});