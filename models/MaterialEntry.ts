import { Model, DataTypes } from 'sequelize';
import sequelize from '../config/database';
import Event from './Event';

interface MaterialEntryAttributes {
  id: number;
  event_id: number;
  contributor_name: string;
  material_type: string;
  weight: number;
  description?: string;
  place?: string;
  created_at?: Date;
  updated_at?: Date;
}

interface MaterialEntryCreationAttributes extends Omit<MaterialEntryAttributes, 'id'> {}

class MaterialEntry extends Model<MaterialEntryAttributes, MaterialEntryCreationAttributes> implements MaterialEntryAttributes {
  public id!: number;
  public event_id!: number;
  public contributor_name!: string;
  public material_type!: string;
  public weight!: number;
  public description!: string;
  public place!: string;
  public readonly created_at!: Date;
  public readonly updated_at!: Date;
}

MaterialEntry.init(
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    event_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: Event,
        key: 'id',
      },
    },
    contributor_name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    material_type: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    weight: {
      type: DataTypes.DECIMAL(10, 3),
      allowNull: false,
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    place: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
      field: 'created_at',
    },
    updated_at: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
      field: 'updated_at',
    },
  },
  {
    sequelize,
    modelName: 'MaterialEntry',
    tableName: 'MaterialEntries',
    timestamps: false,
  }
);

export default MaterialEntry;