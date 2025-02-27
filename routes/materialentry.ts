import express, { Request, Response, NextFunction } from 'express';
import MaterialEntry from '../models/MaterialEntry';

const router = express.Router();

// Validation middleware
const validateMaterialEntryFields = (req: Request, res: Response, next: NextFunction) => {
  const { contributor_name, material_type, weight, event_id } = req.body;
  const missingFields = [];

  if (!contributor_name || contributor_name.trim() === '') missingFields.push('contributor_name');
  if (!material_type || material_type.trim() === '') missingFields.push('material_type');
  if (!weight || weight <= 0) missingFields.push('weight');
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

// Get all material entries 
router.get('/', async (req, res) => {
  try {
    const materialEntries = await MaterialEntry.findAll({
      order: [['created_at', 'DESC']],
    });
    return res.json(materialEntries);
  } catch (error) {
    console.error('Error fetching material entries:', error);
    return res.status(500).json({ 
      message: 'Internal server error',
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});

// Get material entries by event_id
router.get('/event/:event_id', async (req, res) => {
  try {
    const materialEntries = await MaterialEntry.findAll({
      where: {
        event_id: req.params.event_id
      },
      order: [['created_at', 'DESC']],
    });
    return res.json(materialEntries);
  } catch (error) {
    console.error('Error fetching material entries by event:', error);
    return res.status(500).json({ 
      message: 'Internal server error',
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});

// Create new material entry
router.post('/', validateMaterialEntryFields, async (req, res) => {
  const { contributor_name, material_type, weight, description, event_id, place } = req.body;

  try {
    const materialEntry = await MaterialEntry.create({
      contributor_name,
      material_type,
      weight: parseFloat(weight),
      description,
      event_id: parseInt(event_id),
      place
    });

    return res.status(201).json(materialEntry);
  } catch (error) {
    console.error('Error creating material entry:', error);
    return res.status(500).json({ 
      message: 'Internal server error',
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});

// Update material entry
router.put('/:id', validateMaterialEntryFields, async (req, res) => {
  const { contributor_name, material_type, weight, description, place, event_id } = req.body;
  try {
    const materialEntry = await MaterialEntry.findByPk(req.params.id);

    if (!materialEntry) {
      return res.status(404).json({ message: 'Material entry not found' });
    }

    await materialEntry.update({
      contributor_name,
      material_type,
      weight: parseFloat(weight),
      description,
      place,
      event_id: parseInt(event_id)
    });

    return res.json(materialEntry);
  } catch (error) {
    console.error('Error updating material entry:', error);
    return res.status(500).json({ 
      message: 'Internal server error',
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});

// Delete material entry
router.delete('/:id', async (req, res) => {
  try {
    const materialEntry = await MaterialEntry.findByPk(req.params.id);

    if (!materialEntry) {
      return res.status(404).json({ message: 'Material entry not found' });
    }

    await materialEntry.destroy();
    return res.status(200).json({ 
      message: 'Material entry deleted successfully',
      deletedEntry: {
        id: materialEntry.id,
        contributor_name: materialEntry.contributor_name,
        material_type: materialEntry.material_type
      }
    });
  } catch (error) {
    console.error('Error deleting material entry:', error);
    return res.status(500).json({ 
      message: 'Internal server error',
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
});

export default router;