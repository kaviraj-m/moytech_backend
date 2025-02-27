import express, { Request, Response, NextFunction } from 'express';
import { Op } from 'sequelize';
import FinanceEntry from '../models/FinanceEntry';

const router = express.Router();

// Validation middleware
const validateFinanceEntryFields = (req: Request, res: Response, next: NextFunction) => {
  const { event_id, amount, description, date, category } = req.body;
  const missingFields = [];

  if (!event_id || event_id <= 0) missingFields.push('event_id');
  if (!amount || amount <= 0) missingFields.push('amount');
  if (!description || description.trim() === '') missingFields.push('description');
  if (!date) missingFields.push('date');
  if (!category || category.trim() === '') missingFields.push('category');

  if (missingFields.length > 0) {
    return res.status(400).json({
      message: 'Missing or invalid required fields',
      required: missingFields,
      received: req.body
    });
  }

  next();
};

// Get all finance entries
router.get('/', async (req, res) => {
  try {
    const entries = await FinanceEntry.findAll({
      order: [['date', 'DESC']],
    });
    return res.json(entries);
  } catch (error) {
    console.error('Error fetching finance entries:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// Get finance entries by event_id
router.get('/event/:event_id', async (req, res) => {
  try {
    const entries = await FinanceEntry.findAll({
      where: { event_id: req.params.event_id },
      order: [['date', 'DESC']],
    });

    // Calculate summary
    const summary = {
      total_income: 0,
      total_expense: 0,
      balance: 0,
      entries: entries
    };

    entries.forEach(entry => {
      if (entry.type === 'INCOME') {
        summary.total_income += parseFloat(entry.amount.toString());
      } else {
        summary.total_expense += parseFloat(entry.amount.toString());
      }
    });

    summary.balance = summary.total_income - summary.total_expense;

    return res.json(summary);
  } catch (error) {
    console.error('Error fetching finance entries:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// Create income entry
router.post('/income', validateFinanceEntryFields, async (req, res) => {
  try {
    const entry = await FinanceEntry.create({
      ...req.body,
      type: 'INCOME'
    });
    return res.status(201).json(entry);
  } catch (error) {
    console.error('Error creating income entry:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// Create expense entry
router.post('/expense', validateFinanceEntryFields, async (req, res) => {
  try {
    const entry = await FinanceEntry.create({
      ...req.body,
      type: 'EXPENSE'
    });
    return res.status(201).json(entry);
  } catch (error) {
    console.error('Error creating expense entry:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// Update finance entry
router.put('/:id', validateFinanceEntryFields, async (req, res) => {
  try {
    const entry = await FinanceEntry.findByPk(req.params.id);
    if (!entry) {
      return res.status(404).json({ message: 'Entry not found' });
    }
    await entry.update(req.body);
    return res.json(entry);
  } catch (error) {
    console.error('Error updating finance entry:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// Delete finance entry
router.delete('/:id', async (req, res) => {
  try {
    const entry = await FinanceEntry.findByPk(req.params.id);
    if (!entry) {
      return res.status(404).json({ message: 'Entry not found' });
    }
    await entry.destroy();
    return res.json({ message: 'Entry deleted successfully' });
  } catch (error) {
    console.error('Error deleting finance entry:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

// Get summary of all finances
router.get('/summary', async (req, res) => {
  try {
    const entries = await FinanceEntry.findAll();
    const summary = {
      total_income: 0,
      total_expense: 0,
      balance: 0,
      by_category: {}
    };

    entries.forEach(entry => {
      if (entry.type === 'INCOME') {
        summary.total_income += parseFloat(entry.amount.toString());
      } else {
        summary.total_expense += parseFloat(entry.amount.toString());
      }
    });

    summary.balance = summary.total_income - summary.total_expense;
    return res.json(summary);
  } catch (error) {
    console.error('Error getting finance summary:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});


router.get('/detailed-summary/:event_id', async (req, res) => {
  try {
    const allEntries = await FinanceEntry.findAll({
      where: { event_id: req.params.event_id },
      order: [['date', 'DESC']],
    });

    const summary = {
      event_id: req.params.event_id,
      total_income: 0,
      total_expense: 0,
      balance: 0,
      income_entries: [],
      expense_entries: []
    };

    allEntries.forEach(entry => {
      if (entry.type === 'INCOME') {
        summary.total_income += parseFloat(entry.amount.toString());
        (summary.income_entries as any[]).push(entry);
      } else {
        summary.total_expense += parseFloat(entry.amount.toString());
        (summary.expense_entries as any[]).push(entry);
      }  
    });

    summary.balance = summary.total_income - summary.total_expense;

    return res.json(summary);
  } catch (error) {
    console.error('Error getting detailed finance summary:', error);
    return res.status(500).json({ message: 'Internal server error' });
  }
});

export default router;