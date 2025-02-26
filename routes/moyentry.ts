import express, { Request, Response, NextFunction } from 'express';
import MoyEntry from '../models/MoyEntry';
import { Op } from 'sequelize';

const router = express.Router();

// Validation middleware
const validateMoyEntryFields = (req: Request, res: Response, next: NextFunction) => {
  const { contributor_name, amount, event_id } = req.body;
  const missingFields = [];

  if (!contributor_name || contributor_name.trim() === '') missingFields.push('contributor_name');
  if (!amount || amount <= 0) missingFields.push('amount');
  if (!event_id || event_id <= 0) missingFields.push('event_id');

  if (missingFields.length > 0) {
    return res.status(400).json({
      message: 'Missing or invalid required fields',
      required: missingFields,
      received: req.body
    });
  }

  next();
};

// Get all moy entries 
router.get('/', async (req, res) => {
  try {
    const moyEntries = await MoyEntry.findAll({
      order: [['created_at', 'DESC']],
    });
    return res.json(moyEntries);
  } catch (error) {
    console.error('Error fetching moy entries:', error);
    return res.status(500).json({ 
      message: 'Internal server error',
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});

// Get moy entries by event_id
router.get('/event/:event_id', async (req, res) => {
  try {
    const moyEntries = await MoyEntry.findAll({
      where: {
        event_id: req.params.event_id
      },
      order: [['created_at', 'DESC']],
    });
    return res.json(moyEntries);
  } catch (error) {
    console.error('Error fetching moy entries by event:', error);
    return res.status(500).json({ 
      message: 'Internal server error',
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});

// Create new moy entry
router.post('/', validateMoyEntryFields, async (req, res) => {
  const { contributor_name, amount, notes, event_id, place } = req.body;

  try {
    const moyEntry = await MoyEntry.create({
      contributor_name,
      amount: parseFloat(amount),
      notes,
      event_id: parseInt(event_id),
      place
    });

    return res.status(201).json(moyEntry);
  } catch (error) {
    console.error('Error creating moy entry:', error);
    return res.status(500).json({ 
      message: 'Internal server error',
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});

// Update moy entry
router.put('/:id', validateMoyEntryFields, async (req, res) => {
  const { contributor_name, amount, notes, place } = req.body;

  try {
    const moyEntry = await MoyEntry.findByPk(req.params.id);

    if (!moyEntry) {
      return res.status(404).json({ message: 'Moy entry not found' });
    }

    await moyEntry.update({
      contributor_name,
      amount: parseFloat(amount),
      notes,
      place
    });

    return res.json(moyEntry);
  } catch (error) {
    console.error('Error updating moy entry:', error);
    return res.status(500).json({ 
      message: 'Internal server error',
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});

// Delete moy entry
router.delete('/:id', async (req, res) => {
  try {
    const moyEntry = await MoyEntry.findByPk(req.params.id);

    if (!moyEntry) {
      return res.status(404).json({ message: 'Moy entry not found' });
    }

    await moyEntry.destroy();
    return res.status(200).json({ 
      message: 'Moy entry deleted successfully',
      deletedEntry: {
        id: moyEntry.id,
        contributor_name: moyEntry.contributor_name
      }
    });
  } catch (error) {
    console.error('Error deleting moy entry:', error);
    return res.status(500).json({ 
      message: 'Internal server error',
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});

export default router;